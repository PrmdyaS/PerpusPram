import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:perpus_pram/app/assets/theme.dart';
import 'package:perpus_pram/app/data/model/response_borrow_book.dart';

class LaporanPeminjaman {
  Future<Uint8List> generateLaporanPeminjaman(
      List<BorrowBook> borrowBookList, String subtitle) async {
    final pdf = pw.Document();
    final gap5 = pw.SizedBox(height: 5);
    final gap20 = pw.SizedBox(height: 20);
    final title = pw.Center(
        child: pw.Text(
      'Laporan Peminjaman',
      textAlign: pw.TextAlign.center,
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 28,
      ),
    ));
    final subTitle = pw.Center(
        child: pw.Text(
      subtitle,
      textAlign: pw.TextAlign.center,
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.normal,
        fontSize: 18,
      ),
    ));
    final isEmpty = pw.Center(
      child: pw.Padding(
        padding: const pw.EdgeInsets.all(10.0),
        child: pw.Text(
          "Tidak ada data yang terkait!",
          textAlign: pw.TextAlign.center,
          style: const pw.TextStyle(
            fontSize: 10.0,
          ),
        ),
      ),
    );
    List<pw.Widget> widgets = [];
    pw.Table table() {
      List<pw.TableRow> rows = [];
      if (borrowBookList.isNotEmpty) {
        for (int i = 0; i < borrowBookList.length; i++) {
          rows.add(pw.TableRow(children: <pw.Widget>[
            pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text(
                '${i + 1}.',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 10.0),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text(
                '${borrowBookList[i].books != null ? borrowBookList[i].books!.judul : "Buku sudah dihapus!"}',
                textAlign: pw.TextAlign.left,
                style: const pw.TextStyle(fontSize: 10.0),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text(
                '${borrowBookList[i].users!.username}',
                textAlign: pw.TextAlign.left,
                style: const pw.TextStyle(fontSize: 10.0),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text(
                formatDate('${borrowBookList[i].borrowingDate}'),
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 10.0),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text(
                formatDate('${borrowBookList[i].returnDate}'),
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 10.0),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Text(
                '${borrowBookList[i].status}',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 10.0),
              ),
            ),
          ]));
        }
      }
      return pw.Table(
          border: pw.TableBorder.all(color: PdfColor.fromHex("#F0F0F0")),
          columnWidths: const <int, pw.TableColumnWidth>{
            0: pw.FixedColumnWidth(40),
            1: pw.FixedColumnWidth(100),
            2: pw.FixedColumnWidth(90),
            3: pw.FixedColumnWidth(90),
            4: pw.FixedColumnWidth(90),
            5: pw.FixedColumnWidth(90),
          },
          children: <pw.TableRow>[
            pw.TableRow(
                verticalAlignment: pw.TableCellVerticalAlignment.middle,
                decoration:
                    pw.BoxDecoration(color: PdfColor.fromInt(Primary.value)),
                children: <pw.Widget>[
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10.0),
                    child: pw.Text(
                      "No",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10.0),
                    child: pw.Text(
                      "Judul Buku",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10.0),
                    child: pw.Text(
                      "Username",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10.0),
                    child: pw.Text(
                      "Tanggal Pinjam",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10.0),
                    child: pw.Text(
                      "Tanggal Kembali",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(10.0),
                    child: pw.Text(
                      "Status",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10.0,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ]),
            ...rows,
          ]);
    }

    widgets.add(title);
    widgets.add(gap5);
    widgets.add(subTitle);
    widgets.add(gap20);
    widgets.add(table());
    if (borrowBookList.isEmpty) {
      widgets.add(isEmpty);
    }
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context content) {
          return widgets;
        }));
    return pdf.save();
  }

  Future<void> savePdfFile(String filename, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filepath = "${output.path}/$filename.pdf";
    final file = File(filepath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filepath);
  }

  String formatDate(String dateString) {
    if (dateString != '') {
      DateTime date = DateTime.parse(dateString);
      DateFormat formatter = DateFormat('dd MMMM yyyy', 'id');
      return formatter.format(date);
    }
    return '';
  }
}
