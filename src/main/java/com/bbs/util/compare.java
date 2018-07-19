package com.bbs.util;

import java.util.ArrayList;
import java.util.List;

public class compare {
    public static List<String> Mycompare(List<String> big, List<String> small) {
        List<String> list2 = new ArrayList();
        for (String t : small) {
            if (!big.contains(t)) {
                list2.add(t);
            }
        }
        return list2;
    }
}
