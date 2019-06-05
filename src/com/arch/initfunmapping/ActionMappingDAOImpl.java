package com.arch.initfunmapping;

import java.util.*;
import java.io.File;
import org.jdom.*;
import org.jdom.input.*;
import org.jdom.*;
import com.arch.util.*;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: shenghao</p>
 * @author not attributable
 * @version 1.0
 */

public class ActionMappingDAOImpl implements ActionMappingDAO {
    public ActionMapping getActionMapping(String sourceName) {
        HashMap actionMappings = new HashMap(10);
        HashMap transMappings = new HashMap(10);
        try {
             SysConst.trace("1:System begin init ActionMapping function.xml file.");
            SAXBuilder builder = new SAXBuilder();
            Document funcDoc = builder.build(new File(SysConst.
                    FUNCTION_FILE_NAME));
            Element root = funcDoc.getRootElement();
            List allChildren = root.getChildren();
            for (int i = 0; i < allChildren.size(); i++) {
                actionMappings.put(((Element) allChildren.get(i)).getChild(
                        "FunctionId").getText(),
                                   ((Element) allChildren.get(i)).
                                   getChild("ActionName").getText());
            }
        } catch (Exception e) {
            SysConst.trace(
                    "Error occur in ActionMappingDAOImpl.getActionMapping() method,cause:");
            SysConst.trace(e.getMessage());
        }
        SysConst.trace("Complete ActionMappingDAOImpl.getActionMapping()!");
        return new ActionMapping(actionMappings, transMappings);
    }
}
