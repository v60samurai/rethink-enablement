// Convert session-plan/pre-work.html to session-plan/building-pre-work-rethink-systems.pdf using Playwright.
// Run from the repo root:
//   pnpm dlx playwright@latest install chromium   # first time only
//   node session-plan/print-pdf.mjs

import { chromium } from 'playwright';
import path from 'node:path';
import url from 'node:url';

const here = path.dirname(url.fileURLToPath(import.meta.url));
const htmlPath = path.join(here, 'pre-work.html');
const pdfPath = path.join(here, 'building-pre-work-rethink-systems.pdf');
const fileUrl = url.pathToFileURL(htmlPath).toString();

const browser = await chromium.launch();
const context = await browser.newContext();
const page = await context.newPage();

await page.goto(fileUrl, { waitUntil: 'networkidle' });
await page.emulateMedia({ media: 'print' });
await page.pdf({
  path: pdfPath,
  format: 'A4',
  printBackground: true,
  margin: { top: '18mm', right: '14mm', bottom: '18mm', left: '14mm' },
  preferCSSPageSize: false,
});
await browser.close();

console.log(`PDF written to ${pdfPath}`);
