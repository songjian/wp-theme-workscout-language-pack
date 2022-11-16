import polib
import uuid
import hashlib
import requests
import json
import sys

def baidu_translation_api(q, from_lang:str='en', to_lang:str='zh') :
    appkey='UqwHb74UtHP4IVbIerX8'

    params={
        'q': q,
        'appid' : '20210918000948657',
        'salt': str(uuid.uuid4()),
        'from': from_lang,
        'to': to_lang,
    }

    def _sign(params) :
        str = params['appid']+params['q']+params['salt']+appkey
        return hashlib.md5(str.encode()).hexdigest()

    params['sign'] = _sign(params)

    api_url = 'https://fanyi-api.baidu.com/api/trans/vip/translate'

    r = requests.get(api_url, params)

    return r.text


po = polib.pofile(sys.argv[1])

for entry in po:
    res = baidu_translation_api(entry.msgid)
    trans_result = json.loads(res)
    print('dddd', trans_result)
    entry.msgstr = trans_result['trans_result'][0]['dst']
    print(entry.msgid, entry.msgstr)

po.save(sys.argv[1])
