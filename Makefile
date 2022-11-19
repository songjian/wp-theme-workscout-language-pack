workscout-zh_CN.mo: workscout-zh_CN.po
	msgfmt $< -o $@

workscout_core-zh_CN.mo: workscout_core-zh_CN.po
	msgfmt $< -o $@

wp-job-manager-companies-zh_CN.mo: wp-job-manager-companies-zh_CN.po
	msgfmt $< -o $@

workscout-zh_CN.po: workscout.pot 
	msginit -i $< -l zh_CN -o $@

workscout_core-zh_CN.po: workscout_core.pot
	msginit -i $< -l zh_CN -o $@

wp-job-manager-companies-zh_CN.po: wp-job-manager-companies.pot
	msginit -i $< -l zh_CN -o $@

workscout.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/themes/workscout/languages/workscout.pot ./

workscout_core.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/plugins/workscout-core/languages/workscout_core.pot ./

wp-job-manager-companies.pot:
	rsync -av hk2:/wwwphp/jobs/wp-content/plugins/wp-job-manager-companies/languages/$@ ./

.PHONY: trans-workscout
trans-workscout: workscout-zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: trans-workscout_core
trans-workscout_core: workscout_core-zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: trans-wp-job-manager-companies
trans-wp-job-manager-companies: wp-job-manager-companies-zh_CN.po
	. venv/bin/activate && python baidu_translation_api.py $<

.PHONY: upload-workscout
upload-workscout: workscout-zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/languages/themes/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/languages/themes/$<

.PHONY: upload-workscout_core
upload-workscout_core: workscout_core-zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/languages/plugins/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/languages/plugins/$<

.PHONY: upload-wp-job-manager-companies
upload-wp-job-manager-companies: wp-job-manager-companies-zh_CN.mo
	rsync -av $< hk2:/wwwphp/jobs/wp-content/languages/plugins/ && \
	ssh hk2 chown www:www /wwwphp/jobs/wp-content/languages/plugins/$<
