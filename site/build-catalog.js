const fs   = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const GITHUB_USER   = "PUSHPAK-JAISWAL";
const GITHUB_REPO   = "DBATU-CP";
const GITHUB_BRANCH = "main";

const ROOT       = path.join(__dirname, "..");
const OUTPUT_DIR = path.join(__dirname, "public");
const OUT_FILE   = path.join(OUTPUT_DIR, "catalog.json");

const SKIP = new Set(["site", ".github", "node_modules", ".git"]);

function pdfUrl(folder, filename) {
  return [
    `https://raw.githubusercontent.com/${GITHUB_USER}/${GITHUB_REPO}/${GITHUB_BRANCH}`,
    encodeURIComponent(folder),
    encodeURIComponent(filename)
  ].join("/");
}

// Same as build.js — just grab the first line
function getFirstLine(filePath) {
  try {
    const raw = execSync(`pdftotext "${filePath}" -layout -nopgbrk -`, {
      encoding: "utf-8"
    });
    return raw.split("\n")[0].trim();
  } catch {
    return "";
  }
}

// "100       The 3n + 1 problem" → { id: "100", title: "The 3n + 1 problem" }
function parseFirstLine(line, fallback) {
  const match = line.match(/^(\d+)\s+(.+)$/);
  if (match) {
    return { id: match[1], title: match[2].trim() };
  }
  return { id: fallback, title: line.length > 5 ? line : fallback };
}

function build() {
  const folders = fs.readdirSync(ROOT);
  const catalog = [];

  for (const folder of folders) {
    const folderPath = path.join(ROOT, folder);
    if (!fs.statSync(folderPath).isDirectory()) continue;
    if (SKIP.has(folder)) continue;

    const files   = fs.readdirSync(folderPath);
    const pdfFile = files.find(f => f.toLowerCase().endsWith(".pdf"));
    if (!pdfFile) continue;

    const firstLine       = getFirstLine(path.join(folderPath, pdfFile));
    const { id, title }   = parseFirstLine(firstLine, folder);

    catalog.push({ id, title, pdfUrl: pdfUrl(folder, pdfFile) });
  }

  if (!fs.existsSync(OUTPUT_DIR))
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });

  fs.writeFileSync(OUT_FILE, JSON.stringify(catalog, null, 2));
  console.log(`✅ catalog.json written — ${catalog.length} problems`);
}

build();
