workscout-zh_CN.mo: workscout-zh_CN.po
	msgfmt $< -o $@

workscout-zh_CN.po: workscout.pot 
	msginit -i $< -l zh_CN -o $@

workscout_core-zh_CN.mo: workscout_core-zh_CN.po
	msgfmt $< -o $@

workscout_core-zh_CN.po: workscout_core.pot
	msginit -i $< -l zh_CN -o $@

workscout.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/workscout.pot ./

workscout_core.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/plugins/workscout-core/languages/workscout_core.pot ./

.PHONY: trans-workscout
trans-workscout: workscout-zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: trans-workscout_core
trans-workscout_core: workscout_core-zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: upload-workscout
upload-workscout: workscout-zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/languages/themes/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/languages/themes/$<

.PHONY: upload-workscout_core
upload-workscout_core: workscout_core-zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/languages/plugins/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/languages/plugins/$<
