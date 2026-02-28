import { readFileSync, readdirSync, statSync, existsSync, mkdirSync, writeFileSync } from "fs";
import { join, extname } from "path";
import pdfModule from "pdf-parse";
const pdf = pdfModule || pdfModule;

const ROOT = join(__dirname, "..");
const OUTPUT_DIR = join(__dirname, "public");
const DATA_FILE = join(OUTPUT_DIR, "data.json");

const languageMap = {
  ".cpp": "C++",
  ".c": "C",
  ".java": "Java",
  ".py": "Python",
  ".js": "JavaScript",
  ".ts": "TypeScript",
  ".sh": "Bash",
  ".R": "R",
  ".ino": "Arduino",
  ".v": "V"
};

async function extractPDFText(filePath) {
  const dataBuffer = fs.readFileSync(filePath);
  const data = await pdf(dataBuffer);
  return data.text ? data.text.trim() : "";
}

async function build() {
  const folders = readdirSync(ROOT);
  const problems = [];

  for (const folder of folders) {
    const folderPath = join(ROOT, folder);

    if (!statSync(folderPath).isDirectory()) continue;
    if (folder === "site" || folder === ".github") continue;

    const files = readdirSync(folderPath);

    const pdfFile = files.find(f => f.endsWith(".pdf"));
    if (!pdfFile) continue;

    const solutions = {};

    for (const file of files) {
      const ext = extname(file);
      if (languageMap[ext]) {
        const code = readFileSync(join(folderPath, file), "utf-8");
        solutions[languageMap[ext]] = code;
      }
    }

    if (Object.keys(solutions).length === 0) continue;

    const questionText = await extractPDFText(
      join(folderPath, pdfFile)
    );

    problems.push({
      id: folder,
      title: folder,
      question: questionText,
      solutions
    });
  }

  if (!existsSync(OUTPUT_DIR)) {
    mkdirSync(OUTPUT_DIR, { recursive: true });
  }

  writeFileSync(DATA_FILE, JSON.stringify(problems, null, 2));
  console.log("Site data generated successfully.");
}

build();