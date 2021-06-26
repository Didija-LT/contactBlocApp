class Message {

  int id;
  int contactId;
  DateTime dateTime;
  String content;
  String type;
  bool selected=false;

  Message({ required this.id,required this.contactId,required this.dateTime, required this.content,required this.type,required this.selected});
}
