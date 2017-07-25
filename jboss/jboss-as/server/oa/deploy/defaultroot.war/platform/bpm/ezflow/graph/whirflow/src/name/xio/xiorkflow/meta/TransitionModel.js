
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function TransitionModel(fromMetaNodeModel, toMetaNodeModel, id) {
    this.base = MetaModel;
    this.base();

    //
    if (id) {
        this.setID(id);
    }

    //
    this.setMetaNodeModel(fromMetaNodeModel, toMetaNodeModel);
    
     //属性
	this.attributes = new Map();
    //
    this._check();
}
TransitionModel.prototype = new MetaModel();

//
TransitionModel.prototype._check = function () {
    if (this.isValidity()) {
        return;
    }
    if (this.getFromMetaNodeModel()) {
        this.getFromMetaNodeModel().removeFrom(this);
    }
    if (this.getToMetaNodeModel()) {
        this.getToMetaNodeModel().removeTo(this);
    }
};

//
TransitionModel.prototype.isValidity = function () {
    if (!this.getFromMetaNodeModel()) {
        return false;
    }
    if (!this.getFromMetaNodeModel().isFromValidity()) {
        return false;
    }
    if (!this.getToMetaNodeModel()) {
        return false;
    }
    if (!this.getToMetaNodeModel().isToValidity()) {
        return false;
    }
    return true;
};

//
TransitionModel.prototype.setMetaNodeModel = function (fromMetaNodeModel, toMetaNodeModel) {
    if (this.fromMetaNodeModel) {
        this.fromMetaNodeModel.removeFrom(this);
    }
    if (this.toMetaNodeModel) {
        this.toMetaNodeModel.removeTo(this);
    }
    this.fromMetaNodeModel = fromMetaNodeModel;
    this.toMetaNodeModel = toMetaNodeModel;
    this.fromMetaNodeModel.addFrom(this);
    this.toMetaNodeModel.addTo(this);
};
TransitionModel.prototype.getFromMetaNodeModel = function () {
    return this.fromMetaNodeModel;
};
TransitionModel.prototype.getToMetaNodeModel = function () {
    return this.toMetaNodeModel;
};

//
TransitionModel.prototype._updateOffset = function () {
    if (!this.getFromMetaNodeModel()) {
        return false;
    }
    if (!this.getToMetaNodeModel()) {
        return false;
    }

    //
    var fromOffset = this.getFromOffset();
    if (fromOffset) {
        var size = this.getFromMetaNodeModel().getSize();
        var width = size.getWidth();
        var height = size.getHeight();
        var xOffset = fromOffset.getX();
        var yOffset = fromOffset.getY();
        if (xOffset < 0) {
            xOffset = 0;
        }
        if (xOffset > width) {
            xOffset = width;
        }
        if (yOffset < 0) {
            yOffset = 0;
        }
        if (yOffset > height) {
            yOffset = height;
        }
        if ((xOffset != toOffset.getX()) || (yOffset != toOffset.getY())) {
            fromOffset.setXY(xOffset, yOffset);
        }
    }

    //
    var toOffset = this.getToOffset();
    if (toOffset) {
        var size = this.getToMetaNodeModel().getSize();
        var width = size.getWidth();
        var height = size.getHeight();
        var xOffset = toOffset.getX();
        var yOffset = toOffset.getY();
        if (xOffset < 0) {
            xOffset = 0;
        }
        if (xOffset > width) {
            xOffset = width;
        }
        if (yOffset < 0) {
            yOffset = 0;
        }
        if (yOffset > height) {
            yOffset = height;
        }
        if ((xOffset != toOffset.getX()) || (yOffset != toOffset.getY())) {
            toOffset.setXY(xOffset, yOffset);
        }
    }
};

//
TransitionModel.prototype.setFromOffset = function (offset) {
    if (offset == null) {
        return;
    }
    this.fromOffset = offset;
    this.notifyObservers(TransitionModel.TRANSITION_POSITION_CHANGED);
};
TransitionModel.prototype.getFromOffset = function () {
    return this.fromOffset;
};
TransitionModel.prototype.setToOffset = function (offset) {
    if (offset == null) {
        return;
    }
    this.toOffset = offset;
    this.notifyObservers(TransitionModel.TRANSITION_POSITION_CHANGED);
};
TransitionModel.prototype.getToOffset = function () {
    return this.toOffset;
};

//
TransitionModel.prototype.update = function (observable, arg) {
    switch (arg) {
      case MetaNodeModel.POSITION_CHANGED:
        this.notifyObservers(TransitionModel.TRANSITION_POSITION_CHANGED);
        break;
      case MetaNodeModel.SIZE_CHANGED:
        this._updateOffset();
        break;
    }
};


//条件表达式

TransitionModel.prototype.getConditionExpression = function () {
    return this.conditionExpression;
};
TransitionModel.prototype.setConditionExpression = function (data) {
    return this.conditionExpression = data ;
};
//条件表达式类型

TransitionModel.prototype.getConditionExpressionType = function () {
    return this.conditionExpressionType;
};
TransitionModel.prototype.setConditionExpressionType = function (data) {
    return this.conditionExpressionType = data ;
};

//条件表达式显示名

TransitionModel.prototype.getConditionExpressionDisplay = function () {
    return this.conditionExpressionDisplay;
};
TransitionModel.prototype.setConditionExpressionDisplay = function (data) {
    return this.conditionExpressionDisplay = data ;
};


//取排序码
TransitionModel.prototype.getSortNum = function () {
    return this.sortNum;
};
TransitionModel.prototype.setSortNum = function (data) {
    this.sortNum = data ;
};


//条件成立时是否默认选中

TransitionModel.prototype.getDefaultChooseType= function () {
    return this.defaultChooseType;
};
TransitionModel.prototype.setDefaultChooseType = function (data) {
    this.defaultChooseType = data ;
};


//条件成立时是否必须经过
TransitionModel.prototype.getMustChooseType= function () {
    return this.mustChooseType;
};
TransitionModel.prototype.setMustChooseType = function (data) {
    this.mustChooseType = data ;
};


//
TransitionModel.prototype.suicide = function () {
    if (this.getFromMetaNodeModel()) {
        this.getFromMetaNodeModel().removeFrom(this);
    }
    if (this.getToMetaNodeModel()) {
        this.getToMetaNodeModel().removeTo(this);
    }
    this.notifyObservers(TransitionModel.SUICIDE);
};


//属性相关操作方法
//设置属性
TransitionModel.prototype.setAttribute = function (name,value) {
    this.attributes.put(name,value);
};
//获取属性
TransitionModel.prototype.getAttribute = function (name) {
    return this.attributes.get(name);
};



//
TransitionModel.SUICIDE = "TRANSITION_SUICIDE";

//
TransitionModel.TYPE_TRANSITION = "XIORKFLOW_TRANSITION";
TransitionModel.prototype.type = TransitionModel.TYPE_TRANSITION;

//
TransitionModel.TRANSITION_POSITION_CHANGED = "TRANSITION_POSITION_CHANGED";

