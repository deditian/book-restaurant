class SectionsTable {
  String section;
  List<TableModel> tables;

  SectionsTable({required this.section, required this.tables});

  factory SectionsTable.fromJson(Map<String, dynamic> json) {
    return SectionsTable(
      section: json['section'],
      tables: (json['tables'] as List)
          .map((tableJson) => TableModel.fromJson(tableJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['section'] = this.section;
    if (this.tables != null) {
      data['tables'] = this.tables.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableModel {
  final int id;
  final String tableNumber;
  int? idOrder;

  TableModel({
    required this.id,
    required this.tableNumber,
    this.idOrder,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      tableNumber: json['tableNumber'],
      idOrder: json['id_order']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'id_order': idOrder,
    };
  }
}

class SectionsData {
  List<SectionsTable> sections;

  SectionsData({required this.sections});

  factory SectionsData.fromJson(Map<String, dynamic> json) {
    return SectionsData(
      sections: (json['sections_table'] as List)
          .map((sectionJson) => SectionsTable.fromJson(sectionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sections_table'] = this.sections.map((v) => v.toJson()).toList();
    return data;
  }
}
