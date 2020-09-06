#!/usr/bin/env node

function sleep(ms) {
    ms = (ms) ? ms : 0;
    return new Promise(resolve => {setTimeout(resolve, ms);});
}

process.on('uncaughtException', (error) => {
    console.error(error);
    process.exit(1);
});

process.on('unhandledRejection', (reason, p) => {
    console.error(reason, p);
    process.exit(1);
});

const puppeteer = require('puppeteer');

// console.log(process.argv);

if (!process.argv[2]) {
    console.error('ERROR: no url arg\n');

    console.info('for example:\n');
    console.log('  docker run --shm-size 1G --rm -v /tmp:/screenshots \\');
    console.log('  alekzonder/puppeteer:latest screenshot \'https://www.google.com\'\n');
    process.exit(1);
}


var auth = process.argv[2];

var url = process.argv[3];

var now = new Date();

var dateStr = now.toISOString();

var height = 1400;
var width = 1400;

var delay = 0;

var isMobile = false;

let filename = `full_screenshot_${width}_${height}.png`;

(async() => {

    const browser = await puppeteer.launch({
        args: [
        '--no-sandbox',
        '--disable-setuid-sandbox'
        ]
    });

    const page = await browser.newPage();

    const auth_header = 'Basic ' + new Buffer.from(auth).toString('base64');
    await page.setExtraHTTPHeaders({'Authorization': auth_header});

    await page.authenticate({'username':'admin', 'password': 'prod-operator'});

    page.setViewport({
        width,
        height
    });

    await page.goto(url, {waitUntil: 'networkidle2'});

    await sleep(delay);

    await page.screenshot({path: `/screenshots/${filename}`, fullPage: true});

    browser.close();

    console.log(
        JSON.stringify({
            date: dateStr,
            timestamp: Math.floor(now.getTime() / 1000),
            filename,
            width,
            height
        })
    );

})();
