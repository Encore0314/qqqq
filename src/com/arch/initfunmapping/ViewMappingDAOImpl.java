package com.arch.initfunmapping;

import java.util.*;
import com.arch.util.*;
import java.io.File;
import org.jdom.Document;
import org.jdom.input.SAXBuilder;
import org.jdom.Element;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class ViewMappingDAOImpl implements ViewMappingDAO {
    public ViewMappingDAOImpl() {
    }

    public ViewMapping getViewMapping() {
        HashMap viewmap = new HashMap(10);
        try {
            SAXBuilder builder = new SAXBuilder();
            Document funcDoc = builder.build(new File(SysConst.FUNCTION_FILE_NAME));
            Element root = funcDoc.getRootElement();
            List allChildren = root.getChildren();
            for (int i = 0; i < allChildren.size(); i++) {
                viewmap.put(((Element) allChildren.get(i)).getChild(
                        "FunctionId").getText() + ".Success",
                            ((Element) allChildren.get(i)).
                            getChild("SuccessPage").getText());
                viewmap.put(((Element) allChildren.get(i)).getChild(
                        "FunctionId").getText() + ".Fault",
                            ((Element) allChildren.get(i)).
                            getChild("FaultPage").getText());

            }
        } catch (Exception e) {
            SysConst.trace(
                    "Error occur in ViewMappingDAOImpl.getViewMapping() method,cause:");
            SysConst.trace(e.getMessage());
        }
        SysConst.trace("Complete ViewMappingDAOImpl.getViewMapping()!");
        return new ViewMapping(viewmap);
    }
}
