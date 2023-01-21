import 'package:crypto_portfolio/modal/user_item_model.dart';
import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {
  final UserItemModel userItemModel;
  final Function deleteUser;
  const UserItem({Key? key, required this.userItemModel,
  required this.deleteUser}) : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black54,
          radius: 30,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                child: Text(' '),
              ),
            ),
          ),
        ),
        title: Text(
          widget.userItemModel.userName,
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Text(widget.userItemModel.userMobile
            //style: Theme.of(context).textTheme.bodyText2,
            ),
        trailing: // MediaQuery.of(context).size.width > 600
            //     ? TextButton.icon(
            //         onPressed: () => widget.deleteTx(widget.transaction.id),
            //         icon: const Icon(Icons.delete),
            //         style: TextButton.styleFrom(
            //             primary: Theme.of(context).primaryColor),
            //         label: const Text(
            //           'Delete',
            //         ))
            //:
            IconButton(
          onPressed: () => widget.deleteUser(widget.userItemModel.userID),
          icon: const Icon(Icons.delete),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
    ;
  }
}
