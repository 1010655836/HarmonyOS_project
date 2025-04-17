import ItemData from './ItemData';

export class MainViewModel {
  getSwiperImages(): Array<Resource> {
    const swiperImages: Resource[] = [
      $r('app.media.fig1'),
      $r('app.media.fig2'),
      $r('app.media.fig3'),
      $r('app.media.fig4')
    ]
    return swiperImages;
  }

  getFirstGridData(): Array<ItemData> {
    const firstGridData: ItemData[] = [
      new ItemData(0, '我的最爱', $r('app.media.love')),
      new ItemData(1, '历史记录', $r('app.media.record')),
      new ItemData(2, '消息', $r('app.media.message')),
      new ItemData(3, '购物车', $r('app.media.shopping')),
      new ItemData(4, '我的目标', $r('app.media.target')),
      new ItemData(5, '圈子', $r('app.media.circle')),
      new ItemData(6, '收藏', $r('app.media.favorite')),
      new ItemData(7, '回收站', $r('app.media.recycle'))
    ];
    return firstGridData;
  }

  getSttingListData(): Array<Array<ItemData>> {
    let settingListData: ItemData[][] = [
      [
        new ItemData(0, '推送通知', $r('app.media.news'), '切换按钮'),
      ],
      [
        new ItemData(1, '字体大小调节', $r('app.media.data')),
        new ItemData(2, '菜单设置', $r('app.media.menu')),
      ],
      [
        new ItemData(3, '清除缓存', $r('app.media.storage')),
        new ItemData(4, '隐私协议', $r('app.media.person_shield')),
      ],
      [
        new ItemData(5, '关于', $r('app.media.about'))
      ]
    ];
    return settingListData;
  }
}

export default new MainViewModel();