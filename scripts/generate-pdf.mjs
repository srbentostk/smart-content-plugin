import puppeteer from 'puppeteer';
import { fileURLToPath } from 'url';
import { dirname, resolve } from 'path';

const __dirname = dirname(fileURLToPath(import.meta.url));
const htmlPath = resolve(__dirname, '..', 'templates', 'instalacao.html');
const pdfPath = resolve(__dirname, '..', 'templates', 'instalacao.pdf');

const browser = await puppeteer.launch({ headless: true });
const page = await browser.newPage();
await page.goto(`file://${htmlPath}`, { waitUntil: 'networkidle0' });
await page.pdf({
  path: pdfPath,
  format: 'A4',
  printBackground: true,
  margin: { top: '1cm', bottom: '1cm', left: '1cm', right: '1cm' }
});
await browser.close();
console.log(`PDF gerado: ${pdfPath}`);
