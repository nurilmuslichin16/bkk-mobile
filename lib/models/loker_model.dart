class LokerModel {
  int idPer;
  DateTime tglUpload;
  String namaPer;
  int kuota;
  int biaya;
  String deskripsi;
  String image;
  String jurusan;
  String usia;
  String tinggiBadan;
  String beratBadan;

  LokerModel({
    this.idPer,
    this.tglUpload,
    this.namaPer,
    this.kuota,
    this.biaya,
    this.deskripsi,
    this.image,
    this.jurusan,
    this.usia,
    this.tinggiBadan,
    this.beratBadan,
  });

  LokerModel.fromJson(Map<String, dynamic> json) {
    idPer = json['id_per'];
    tglUpload = DateTime.parse(json['tgl_upload']);
    namaPer = json['nama_per'];
    kuota = json['kuota'];
    biaya = json['biaya'];
    deskripsi = json['deskripsi'];
    image = json['image'];
    jurusan = json["jurusan"];
    usia = json["usia"];
    tinggiBadan = json["tinggi_badan"];
    beratBadan = json["berat_badan"];
  }

  Map<String, dynamic> toJson() {
    return {
      'idPer': idPer,
      'tglUpload': tglUpload.toString(),
      'namaPer': namaPer,
      'kuota': kuota,
      'biaya': biaya,
      'deskripsi': deskripsi,
      'image': image,
      "jurusan": jurusan,
      "usia": usia,
      "tinggi_badan": tinggiBadan,
      "berat_badan": beratBadan,
    };
  }
}
