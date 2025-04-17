export default class ItemData {
  id: number;

  title: ResourceStr;

  img: Resource;

  others?: ResourceStr;

  constructor(id:number, title: ResourceStr, img: Resource, others?:ResourceStr) {
    this.id = id;
    this.title = title;
    this.img = img;
    this.others = others;
  }
}
