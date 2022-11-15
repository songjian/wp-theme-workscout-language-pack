zh_CN.mo: zh_CN.po
	msgfmt zh_CN.po -o zh_CN.mo

zh_CN.po: workscout.pot
	msginit -i workscout.pot -l zh_CN

workscout.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/workscout.pot ./

.PHONY: trans
trans:
	. venv/bin/activate && python baidu_translation_api.py

.PHONY: upload
upload:
	rsync -av zh_CN.mo hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/themes/workscout/languages/zh_CN.mo