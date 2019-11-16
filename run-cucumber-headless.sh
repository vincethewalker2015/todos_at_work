#!/bin/bash

test `curl https://staging.hihostels.com|wc -w` -gt 5 || 
	ssh ubuntu@staging.hihostels.com sudo /opt/nginx/sbin/nginx -s reload

cd ~/cucumber
test `ls capybara-* 2> /dev/null | wc -l` -eq 0 || exit 999
test `ls /tmp/click-failed* 2> /dev/null | wc -l` -eq 0 || exit 999

git pull origin 

DRIVER=chrome_headless cucumber 2>&1 | tee /tmp/cucumber.log

test `ls capybara-* 2> /dev/null | wc -l` -ne 0 || exit 0

echo "retrying failed tests"
rm capybara-* > /dev/null 2>&1
rm /tmp/click_failed_* > /dev/null 2>&1
rm /tmp/cucumber-retry-1.log > /dev/null 2>&1
cat /tmp/cucumber.log |grep "cucumber features/"| while read failed; do
        echo retrying $failed
	/bin/bash -l -c  "DRIVER=chrome_headless $failed" >> /tmp/cucumber-retry-1.log
done

test `ls capybara-* 2> /dev/null | wc -l` -ne 0 || exit 0

echo "second retry"
rm capybara-* > /dev/null 2>&1
rm /tmp/click_failed_* > /dev/null 2>&1
rm /tmp/cucumber-retry-2.log > /dev/null 2>&1
cat /tmp/cucumber-retry-1.log |grep "cucumber features/"| while read failed; do
        echo retrying $failed
	/bin/bash -l -c  "DRIVER=chrome_headless $failed" >> /tmp/cucumber-retry-2.log
done

test `ls capybara-* 2> /dev/null | wc -l` -ne 0 || exit 0

echo "third retry"
rm capybara-* > /dev/null 2>&1
rm /tmp/click_failed_* > /dev/null 2>&1
rm /tmp/cucumber-retry-3.log > /dev/null 2>&1
cat /tmp/cucumber-retry-2.log |grep "cucumber features/"| while read failed; do
        echo retrying $failed
	/bin/bash -l -c  "DRIVER=chrome_headless $failed" >> /tmp/cucumber-retry-3.log
done

test `ls capybara-* 2> /dev/null | wc -l` -ne 0 || exit 0

# zip -c cucumber.zip capybara*
# zip -c /tmp/click_failed.zip /tmp/click_failed*
# but risky to attach /tmp/c* here but should be ok
echo 'Logs attached.' | mail -s 'Cucumber failing!' jasonahooper@gmail.com \
				-A capybara* -A /tmp/c*
# rm cucumber.zip 2> /dev/null
# rm /tmp/click_failed.zip 2> /dev/null