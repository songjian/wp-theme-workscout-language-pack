#!/bin/bash
msgfmt zh_CN.po -o zh_CN.mo
rsync -av zh_CN.mo hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/
ssh hk2 chown www:www /wwwphp/jobs/wp-content/themes/workscout/languages/zh_CN.mo
