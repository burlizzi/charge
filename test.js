import puppeteer from 'puppeteer';

const browser = await puppeteer.launch();
const page = await browser.newPage();


function delay(time) {
    return new Promise(function(resolve) { 
        setTimeout(resolve, time)
    });
 }
 
await page.goto('https://driver.chargepoint.com/stations/6772225',{'timeout': 10000});
await delay(10000);

const items = await page.evaluate(() => {
    const elements = [...document.getElementsByClassName('sc-fHCFno jVERGd')];
    const results = elements.map((el) => ({
    title: el.textContent
    }));
    return JSON.stringify(results);
});
console.table(items);
page.reload();
await delay(60000);

 