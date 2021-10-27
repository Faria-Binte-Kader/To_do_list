class ModelTask{
  String text;
  bool? isSelected;

  ModelTask(this.text,this.isSelected);


  ModelTask.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        isSelected = json['isSelected'];

  Map<String, dynamic> toJson() => {
    'text': text,
    'isSelected': isSelected,
  };
}