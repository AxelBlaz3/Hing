import 'package:flutter/material.dart';
import 'package:hing/constants.dart';
import 'package:hing/generated/l10n.dart';
import 'package:hing/models/comment/comment.dart';
import 'package:hing/models/recipe/recipe.dart';
import 'package:hing/providers/comment_provider.dart';
import 'package:hing/screens/home/components/feed_action_item.dart';
import 'package:provider/provider.dart';

class CommentFooter extends StatefulWidget {
  final bool isReply;
  final Recipe recipe;
  final Comment comment;
  final Function(Comment) refreshCallback;
  const CommentFooter(
      {Key? key,
      required this.recipe,
      required this.comment,
      required this.isReply,
      required this.refreshCallback})
      : super(key: key);

  @override
  _CommentFooterState createState() => _CommentFooterState();
}

class _CommentFooterState extends State<CommentFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Consumer<CommentProvider>(
            builder: (_, commentProvider, __) => FeedActionItem(
                  iconPath: widget.comment.isLiked
                      ? 'assets/star_filled.svg'
                      : 'assets/star.svg',
                  recipe: widget.recipe,
                  countLabel: widget.comment.likesCount > 0
                      ? S.of(context).xLikes(widget.comment.likesCount)
                      : S.of(context).like,
                  onPressed: () {
                    final CommentProvider commentProvider =
                        context.read<CommentProvider>();

                    if (widget.comment.isLiked) {
                      if (widget.isReply) {
                        commentProvider
                            .unLikeReply(commentId: widget.comment.id.oid)
                            .then((success) {
                          if (success) {
                            widget.refreshCallback(widget.comment
                              ..isLiked = !widget.comment.isLiked
                              ..likesCount = widget.comment.likesCount - 1);
                            commentProvider.notifyCommentChanges();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Retry')));
                          }
                        });
                      } else {
                        commentProvider
                            .unLikeComment(commentId: widget.comment.id.oid)
                            .then((success) {
                          if (success) {
                            widget.refreshCallback(widget.comment
                              ..isLiked = !widget.comment.isLiked
                              ..likesCount = widget.comment.likesCount - 1);
                            commentProvider.notifyCommentChanges();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Retry')));
                          }
                        });
                      }
                    } else {
                      if (widget.isReply) {
                        commentProvider
                            .likeReply(commentId: widget.comment.id.oid)
                            .then((success) {
                          if (success) {
                            widget.refreshCallback(widget.comment
                              ..isLiked = !widget.comment.isLiked
                              ..likesCount = widget.comment.likesCount + 1);
                            commentProvider.notifyCommentChanges();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Retry')));
                          }
                        });
                      } else {
                        commentProvider
                            .likeComment(commentId: widget.comment.id.oid)
                            .then((success) {
                          if (success) {
                            widget.refreshCallback(widget.comment
                              ..isLiked = !widget.comment.isLiked
                              ..likesCount = widget.comment.likesCount + 1);
                            commentProvider.notifyCommentChanges();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Retry')));
                          }
                        });
                      }
                    }
                  },
                )),
        SizedBox(
          width: 16,
        ),
        FeedActionItem(
          iconPath: 'assets/chat.svg',
          recipe: widget.recipe,
          countLabel: widget.comment.repliesCount > 0
              ? S.of(context).xReplies(widget.comment.repliesCount)
              : S.of(context).reply,
          onPressed: () {
            Navigator.of(context).pushNamed(kRepliesRoute, arguments: {
              'recipe': widget.recipe,
              'comment': widget.comment,
              'is_reply': widget.isReply,
              'refresh_callback': widget.refreshCallback
            });
          },
        ),
      ],
    );
  }
}
