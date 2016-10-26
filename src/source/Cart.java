package source;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by hongyangjiang on 8/15/16.
 */
public class Cart {
    private Map<String, Integer> items;

    public Cart() {
        items = new HashMap<String, Integer>();
    }

    public Map<String, Integer> getItems() {
        return items;
    }

    public void increaseQuantity(String itemID, int num) {
        if (items.containsKey(itemID)) {
            items.put(itemID, items.get(itemID) + num);
        } else {
            items.put(itemID, num);
        }
    }

    public void setQuantity(String itemID, int num) {
        items.put(itemID, num);
    }

    public void removeFromCart(String itemID) {
        if (items.containsKey(itemID)) {
            items.remove(itemID);
        }
    }

    public void decreaseQuantity(String itemID, int num) {
        if (items.containsKey(itemID)) {
            items.put(itemID, items.get(itemID) - num);
            if (items.get(itemID) <= 0) {
                removeFromCart(itemID);
            }
        }
    }
}
