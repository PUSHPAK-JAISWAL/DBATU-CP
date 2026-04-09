
const fs   = require("fs");
const path = require("path");

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

function guessTitle(filename) {
  return filename
    .replace(/\.pdf$/i, "")
    .replace(/^\d+\s*[-.]?\s*/, "")
    .trim();
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

    catalog.push({
      id:     folder,
      title:  guessTitle(pdfFile),
      pdfUrl: pdfUrl(folder, pdfFile),
    });
  }

  if (!fs.existsSync(OUTPUT_DIR))
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });

  fs.writeFileSync(OUT_FILE, JSON.stringify(catalog, null, 2));
  console.log(`✅ catalog.json written — ${catalog.length} problems`);
}

build();
