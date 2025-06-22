import { http } from '@kit.NetworkKit';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import ResponseData from '../../viewmodel/ResponseData/ResponseData';
import ListInfo from '../../viewmodel/ResponseData/ListInfo';

const TAG: string = 'HttpUtils';

class Header {
  contentType: string;

  constructor(contentType: string) {
    this.contentType = contentType;
  }
}

export class HttpUtils {
  httpRequest: http.HttpRequest;

  constructor() {
    this.httpRequest = http.createHttp();
  }

  async getHttpRequest(cacheDir: string): Promise<string> {
    let resPicUrl: string = '';
    const url: string =
      'https://developer.huawei.com/system/modules/org.opencms.portal.template.core/resources/harmony/img/jiantou_right.svg';
    const res: http.HttpResponse = await this.httpRequest.request(url, { method: http.RequestMethod.GET });
    let filePath = `${cacheDir}/test.svg`;
    let file = fileIo.openSync(filePath, fileIo.OpenMode.CREATE | fileIo.OpenMode.READ_WRITE);
    resPicUrl = fileUri.getUriFromPath(filePath);
    fileIo.writeSync(file.fd, res.result as ArrayBuffer);
    fileIo.closeSync(file.fd);
    return resPicUrl;
  }

  async postHttpRequest(): Promise<ListInfo[]> {
    let responseData: Array<ListInfo> = [];
    await this.httpRequest.request('https://svc-drcn.developer.huawei.com/community/servlet/consumer' +
      '/partnerActivityService/v1/developer/activity/terminalActivities/list',
      {
        method: http.RequestMethod.POST, extraData: {
        'status': '1',
        'belong': '1',
        'language': 'cn',
        'needTop': 1,
        'displayChannel': [1, 3],
        'count': 4,
        'pagestart': 1,
        'type': '1,4,5,6'
      },
        header: new Header('application/json;charset=UTF-8')
      }).then((data: http.HttpResponse) => {
      let result: ResponseData = JSON.parse(data.result as string);
      responseData = result.value.list;
    }).catch((err: Error) => {
      hilog.info(0x0000, TAG, JSON.stringify(err));
    });
    return responseData;
  }

  destroyHttpRequest() {
    this.httpRequest.destroy();
  }
}