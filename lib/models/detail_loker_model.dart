class DetailLokerModel {
  String idLoker;
  String namaPerusahaan;
  String tanggalAkhir;
  String posisi;
  String deskripsi;
  String gaji;
  String foto;

  DetailLokerModel(
      {this.idLoker,
      this.namaPerusahaan,
      this.tanggalAkhir,
      this.posisi,
      this.deskripsi,
      this.gaji,
      this.foto});

  factory DetailLokerModel.createObject(Map<String, dynamic> object) {
    return DetailLokerModel(
      idLoker: object['id_lowongan'] ?? 'empty',
      namaPerusahaan: object['nama_perusahaan'] ?? 'empty',
      tanggalAkhir: object['tanggal_akhir'] ?? 'empty',
      posisi: object['posisi'] ?? 'empty',
      deskripsi: object['deskripsi'] ?? 'empty',
      gaji: object['gaji'] ?? 'empty',
      foto: object['foto'] ?? 'empty',
    );
  }
}
