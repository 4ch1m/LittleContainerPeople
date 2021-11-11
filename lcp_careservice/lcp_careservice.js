const puppeteer = require("puppeteer");

(async () => {
    let log = msg => {
        console.log((new Date()).toUTCString() + " - " + msg);
    }

    log("starting");
    const browser = await puppeteer.launch( { headless: true,
                                              args: [
                                                  "--disable-gpu",
                                                  "--disable-dev-shm-usage",
                                                  "--no-sandbox",
                                                  "--disable-setuid-sandbox" ]});
    const page = await browser.newPage();

    let targetUrl = (typeof process.env.LCP_CARESERVICE_TARGETURL !== "undefined") ? process.env.LCP_CARESERVICE_TARGETURL : "http://lcp:6081";

    log("navigating to " + targetUrl);
    await page.goto(targetUrl);

    let connected = false;

    for (let i = 0; i < 3; i++) {
        log("checking noVNC connection status");
        let noVncStatus = await page.waitForSelector("#noVNC_status");
        let noVncStatusText = await noVncStatus.evaluate(element => element.textContent);

        connected = noVncStatusText.toLowerCase().includes("connected");

        if (connected) {
            log("noVNC connection established");
            break;
        } else {
            if (i < 2) {
                log("not yet connected via noVNC; waiting to try again");
                await page.waitForTimeout(3000);
            } else {
                log("noVNC not connected");
            }
        }
    }

    if (connected) {
        log("toggle [ CTRL ]");
        let toggleCtrlButton = "#noVNC_toggle_ctrl_button";
        await page.waitForSelector(toggleCtrlButton);
        await page.evaluate(selector => document.querySelector(selector).click(), toggleCtrlButton);

        let lcpAction = async key => {
            log("setting focus on canvas");
            await page.waitForSelector("canvas");
            await page.focus("canvas");
            log(`pressing [ ${key} ]`);
            await page.keyboard.press(key, { delay: 1000 });
        }

        let essentialActions
        for (let activity of [
                "F", // food
                "W", // water
                "D" // dogfood
        ]) {
            await lcpAction(activity);
            await page.waitForTimeout(1500);
        }

        let extraActivities = [
            "A", // alarm clock
            "C", // call
            "P", // patting
            "R", // record
            "B", // book
        ];
        await lcpAction(extraActivities[Math.floor(Math.random() * extraActivities.length)]);

        log("toggle back [ CTRL ]");
        await page.evaluate(selector => document.querySelector(selector).click(), toggleCtrlButton);
    }

    await browser.close();

    log("done.")
})();
