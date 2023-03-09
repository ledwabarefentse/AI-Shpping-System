import 'package:aishop_admin/provider/products_provider.dart';
import 'package:aishop_admin/widgets/header/page_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:responsive_table/responsive_table.dart';

import 'addproduct.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
    Provider.of<ProductsProvider>(context);
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              PageHeader(
                text: 'Products',
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(
                  maxHeight: 700,
                ),
                child: Card(
                  elevation: 1,
                  shadowColor: Colors.black,
                  clipBehavior: Clip.none,
                  child: ResponsiveDatatable(
                    title: !productsProvider.isSearch
                        ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext
                                  context) =>
                                      AddProduct()));
                        },
                        icon: Icon(Icons.add),
                        label: Text("ADD PRODUCT"))
                        : null,
                    actions: [
                      if (productsProvider.isSearch)
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        setState(() {
                                          productsProvider.isSearch = false;
                                        });
                                      }),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.search), onPressed: () {})),
                            )),
                      if (!productsProvider.isSearch)
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                productsProvider.isSearch = true;
                              });
                            })
                    ],
                    headers: productsProvider.productsTableHeader,
                    source: productsProvider.productsTableSource,
                    selecteds: productsProvider.productsSelecteds,
                    showSelect: productsProvider.showSelect,
                    autoHeight: false,
                    onTabRow: (data) {
                      print(data);
                    },
                    onSort: productsProvider.onSort,
                    sortAscending: productsProvider.sortAscending,
                    sortColumn: productsProvider.sortColumn,
                    isLoading: productsProvider.isLoading,
                    onSelect: productsProvider.onSelected,
                    onSelectAll: productsProvider.onSelectAll,
                    footers: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Rows per page:"),
                      ),
                      if (productsProvider.perPages != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton(
                              value: productsProvider.currentPerPage,
                              items: productsProvider.perPages
                                  .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (value) {}),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                            "${productsProvider.currentPage} - ${productsProvider.currentPage} of ${productsProvider.total}"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: productsProvider.previous,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 16),
                        onPressed: productsProvider.next,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      )
                    ],
                  ),
                ),
              ),
            ]));
  }
}