import 'package:characters_actors/business_logic/cubit/app_cubit.dart';
import 'package:characters_actors/business_logic/cubit/app_state.dart';
import 'package:characters_actors/data/models/character.dart';
import 'package:characters_actors/helpers/constants/myColors.dart';
import 'package:characters_actors/helpers/constants/strings.dart';
import 'package:characters_actors/presentation/widjets/character_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? characters;
  List<Character> searchedCharacters = [];
  bool _isSearching = false;
  final searchTxtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context).getAllCharacter();
  }

  Widget buldSearchTextField() {
    return TextField(
      controller: searchTxtController,
      cursorColor: MyColors.mywhite,
      decoration: InputDecoration(
        hintText: 'Find a character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.mywhite, fontSize: 16),
      ),
      style: TextStyle(color: MyColors.mywhite, fontSize: 16),
      onChanged: (searchedCharacter) {
        addItemsSearchedForToSearchedCharacters(searchedCharacter);
      },
    );
  }

  addItemsSearchedForToSearchedCharacters(String searchedCharacter) {
    searchedCharacters = characters!
        .where((character) =>
            character.name!.contains(searchedCharacter.toLowerCase()))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarAcctions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.mywhite,
            )),
        //TODO:
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.mywhite,
            )),
        //TODO:
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    searchTxtController.clear();
  }

  Widget buildBlockWidget() {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        if (state is CharactersIsLoaded) {
          characters = state.charecters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              buildCharactersList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTxtController.text.isEmpty
            ? characters?.length
            : searchedCharacters.length,
        itemBuilder: (context, index) {
          return CharacterItem(
              character: searchTxtController.text.isEmpty
                  ? characters![index]
                  : searchedCharacters[index]);
        });
  }

  Widget buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.mywhite),
    );
  }

  Widget buildNoInternetWidjet() {
    return Center(
      child: Container(
        color: MyColors.mywhite,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'can\'t connect , check your internet',
              style: TextStyle(color: MyColors.myGrey, fontSize: 22),
            ),
            Image.asset('assets/images/connection_error.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? buldSearchTextField() : buildAppBarTitle(),
        actions: buildAppBarAcctions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlockWidget();
          } else {
            return buildNoInternetWidjet();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}

//buildBlockWidget()
