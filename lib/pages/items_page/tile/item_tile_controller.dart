import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:wdb106_sample/model/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'item_tile_state.dart';

export 'item_tile_state.dart';

class ItemTileController extends StateNotifier<ItemTileState> {
  ItemTileController(
    this._ref, {
    @required this.id,
  }) : super(ItemTileState()) {
    _cartControllerRemoveListener = _ref.read(cartProvider).addListener(
      (cartState) {
        final cartItem = cartState.cartItem(stock.item);
        final cartItemQuantity = cartItem?.quantity ?? 0;
        state = state.copyWith(
          quantity: stock.quantity - cartItemQuantity,
        );
      },
    );
  }

  final ProviderReference _ref;

  final int id;
  VoidCallback _cartControllerRemoveListener;

  ItemStock get stock => _ref.read(itemsProvider).state.stock(id);

  void addToCart() => _ref.read(cartProvider).add(stock.item);

  @override
  void dispose() {
    _cartControllerRemoveListener();

    super.dispose();
  }
}
