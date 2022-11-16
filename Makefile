zh_CN.mo: zh_CN.po 
	msgfmt $< -o $@

zh_CN.po: workscout.pot 
	msginit -i $< -l zh_CN -o $@

workscout_core_zh_CN.mo: workscout_core_zh_CN.po
	msgfmt $< -o $@

workscout_core_zh_CN.po: workscout_core.pot
	msginit -i $< -l zh_CN -o $@

workscout.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/workscout.pot ./

workscout_core.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/plugins/workscout-core/languages/workscout_core.pot ./

.PHONY: trans-workscout
trans-workscout: zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: trans-workscout_core
trans-workscout_core: workscout_core_zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: upload-workscout
upload-workscout: zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/themes/workscout/languages/$<

.PHONY: upload-workscout_core
upload-workscout_core: workscout_core_zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/plugins/workscout-core/languages/zh_CN.mo
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/plugins/workscout-core/languages/zh_CN.mo
