const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const ROOT = path.join(__dirname, "..");
const OUTPUT_DIR = path.join(__dirname, "public");
const DATA_FILE = path.join(OUTPUT_DIR, "data.json");

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

function extractPDFText(filePath) {
  try {
    const raw = execSync(`pdftotext "${filePath}" -layout -nopgbrk -`, {
      encoding: "utf-8"
    });

    let text = raw;

    // Remove page numbers like "2/2"
    text = text.replace(/\n?\d+\/\d+\n?/g, "");

    // Remove repeated footer lines (Valladolid etc.)
    text = text.replace(/Universidad.*?\n/g, "");

    // Remove excessive newlines
    text = text.replace(/\n{3,}/g, "\n\n");

    return text.trim();
  } catch (err) {
    console.error("PDF extraction failed:", filePath);
    return "";
  }
}

function build() {
  const folders = fs.readdirSync(ROOT);
  const problems = [];

  for (const folder of folders) {
    const folderPath = path.join(ROOT, folder);

    if (!fs.statSync(folderPath).isDirectory()) continue;
    if (["site", ".github", "node_modules"].includes(folder)) continue;

    const files = fs.readdirSync(folderPath);
    const pdfFile = files.find(f => f.endsWith(".pdf"));
    if (!pdfFile) continue;

    const solutions = {};

    for (const file of files) {
      const ext = path.extname(file);
      if (languageMap[ext]) {
        const code = fs.readFileSync(path.join(folderPath, file), "utf-8");
        solutions[languageMap[ext]] = code;
      }
    }

    if (Object.keys(solutions).length === 0) continue;

    const questionText = extractPDFText(
      path.join(folderPath, pdfFile)
    );

    const firstLine = questionText.split("\n")[0].trim();

    problems.push({
      id: folder,
      title: firstLine.length > 5 ? firstLine : folder,
      question: questionText,
      solutions
    });
  }

  if (!fs.existsSync(OUTPUT_DIR)) {
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });
  }

  fs.writeFileSync(DATA_FILE, JSON.stringify(problems, null, 2));
  console.log("✅ Site data generated successfully.");
}

build();