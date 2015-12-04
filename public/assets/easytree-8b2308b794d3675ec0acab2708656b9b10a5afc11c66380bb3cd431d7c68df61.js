/*!
 * jQuery EasyTree Plugin
 * http://www.EasyJsTree.com
 *
 * Copyright 2014 Matthew Rand
 * Released under the MIT license
 * V1.0.1
 */


(function ($) { $.fn.easytree = function (a) { var b = this; var c = new F(b, a); return c }; var F = function (z, A) { var B = { allowActivate: true, data: null, dataUrl: null, dataUrlJson: null, disableIcons: false, enableDnd: false, ordering: null, slidingTime: 100, minOpenLevels: 0, building: null, built: null, toggling: null, toggled: null, opening: null, opened: null, openLazyNode: null, closing: null, closed: null, canDrop: null, dropping: null, dropped: null, stateChanged: null }; var C; var D = null; var E = new Object(); this.init = function (b, c) { B = $.extend(B, c); init(); C = b; var d = ''; if (B.dataUrl) { ajaxService(B.dataUrl, B.dataUrlJson, function (a) { d = convertInputDataToJson(a); if (!d) { alert("EasyTree: Invalid data!"); return this } buildTree(d); return this }) } else if (B.data) { d = convertInputDataToJson(B.data); if (!d) { alert("EasyTree: Invalid data!"); return this } buildTree(d) } else { d = convertInputDataToJson(C.html()); if (!d) { alert("EasyTree: Invalid data!"); return this } buildTree(d) } return this }; this.options = B; this.rebuildTree = function (a) { var b = a ? convertInputDataToJson(a) : D; if (!b) { alert("EasyTree: Invalid data!") } buildTree(b) }; this.getAllNodes = function () { return D }; this.getNode = function (a) { return getNode(D, a) }; this.addNode = function (a, b) { if (!b) { D.push(a); return } var c = getNode(D, b); if (!a) { return } if (!c.children) { c.children = [] } c.children.push(a) }; this.removeNode = function (a) { removeNode(D, a) }; this.activateNode = function (a) { unactivateAll(D); if (!B.allowActivate) { return } var b = getNode(D, a); if (!b) { return } b.isActive = true; $('#' + b.id).addClass('easytree-active') }; this.toggleNode = function (a) { var b = getNode(D, a); if (!b) { return } toggleNodeBegin(event, D, b) }; function nodeClick(a) { var b = getElementId(this); var c = a.data; var d = getNode(c, b); if (!d) { return } unactivateAll(c); if (!B.allowActivate) { return } d.isActive = true; $('#' + d.id).addClass('easytree-active'); if (B.stateChanged) { var j = getMinifiedJson(c); B.stateChanged(c, j) } } function toggleNodeEvt(a) { var b = getElementId(this); var c = a.data; var d = getNode(c, b); if (!d) { return } toggleNodeBegin(a, c, d) } function toggleNodeBegin(c, d, e) { var f = ''; if (B.toggling) { f = B.toggling(c, d, e); if (f === false) { return false } } if (e.isExpanded) { if (B.closing) { f = B.closing(c, d, e); if (f === false) { return false } } } else { if (B.opening) { f = B.opening(c, d, e); if (f === false) { return false } } } if (e.isLazy && !e.isExpanded) { var g = e.children && e.children.length > 0; f = true; if (B.openLazyNode) { f = B.openLazyNode(c, d, e, g) } if (e.lazyUrl && f !== false) { ajaxService(e.lazyUrl, e.lazyUrlJson, function (a) { if (a.d) { a = a.d } var b = convertInputDataToJson(a); if ($.isArray(b)) { e.children = b } else { e.children = []; e.children.push(b) } buildTree(d); toggleNodeEnd(c, d, e) }); return false } } toggleNodeEnd(c, d, e) } function toggleNodeEnd(a, b, c) { if (c.isExpanded) { openCloseNode(b, c.id, "close"); renderNode(c, "close"); if (B.closed) { B.closed(a, b, c) } } else { openCloseNode(b, c.id, "open"); renderNode(c, "open"); if (B.opened) { B.opened(a, b, c) } } if (B.toggled) { var d = B.toggled(a, b, c) } } function dragStart(a) { if (!B.enableDnd) { return } var b = a.target; while (b) { if (b.className.indexOf("easytree-draggable") > -1) { break } b = b.parentElement } if (!b) { return } unsourceAll(D); unactivateAll(D); $('#' + b.id).addClass('easytree-drag-source'); resetDnd(E); E.createClone = !(b.className.indexOf("easytree-no-clone") > -1); E.dragok = true; E.sourceEl = b; E.sourceId = b.id; E.sourceNode = getNode(D, E.sourceId); return false } function drag(a) { if (!E.dragok) { return } if (!B.enableDnd) { return } if (E.createClone) { if (!E.clone) { E.clone = createClone(E.sourceEl); $(E.clone).appendTo('body') } E.clone.style.left = (a.pageX + 5) + "px"; E.clone.style.top = (a.pageY) + "px" } var b = getDroppableTargetEl(a.clientX, a.clientY); if (!b) { hideDragHelpers(); E.targetEl = null; E.targetId = null; E.targetNode = null; E.canDrop = false; return } if (b.id == E.targetId) { return } E.canDrop = false; window.clearTimeout(E.openDelayTimeout); E.targetEl = b; E.targetId = b.id; E.targetNode = getNode(D, E.targetId); log('source:' + (E.sourceNode && E.sourceNode.text ? E.sourceNode.text : E.sourceId)); log('target:' + (E.targetNode && E.targetNode.text ? E.targetNode.text : E.targetId)); log('isAncester:' + isAncester(E.sourceNode, E.targetId)); var c = $('#' + E.targetId); if (isAncester(E.sourceNode, E.targetId)) { showRejectDragHelper(); return } if (E.targetId == E.sourceId) { hideDragHelpers(); return } if (B.canDrop) { var d = E.sourceNode != null; var e = d ? E.sourceNode : E.sourceEl; var f = E.targetNode != null; var g = f ? E.targetNode : E.targetEl; var h = B.canDrop(a, D, d, e, f, g); if (h === true) { showAcceptDragHelper(); E.canDrop = true; E.openDelayTimeout = window.setTimeout(function () { openCloseNode(D, E.targetId, 'open'); renderNode(E.targetNode, 'open') }, 600); return } else if (h === false) { showRejectDragHelper(); return } } if (c.hasClass('easytree-reject')) { showRejectDragHelper() } else if (c.hasClass('easytree-accept')) { showAcceptDragHelper(); E.canDrop = true; E.openDelayTimeout = window.setTimeout(function () { openCloseNode(D, E.targetId, 'open'); renderNode(E.targetNode, 'open') }, 600) } else { hideDragHelpers() } return false } function dragEnd(a) { var b = E.sourceNode != null; var c = b ? E.sourceNode : E.sourceEl; var d = E.targetNode != null; var e = d ? E.targetNode : E.targetEl; var f = E.canDrop; hideDragHelpers(); $('#_st_clone_').remove(); if (c === null || e === null) { resetDnd(E); return false } if (B.dropping) { var g = B.dropping(a, D, b, c, d, e, f); if (g === false) { resetDnd(E); return } } if (E.targetNode && E.sourceNode && f) { if (!E.targetNode.children) { E.targetNode.children = [] } removeNode(D, E.sourceId); E.targetNode.children.push(E.sourceNode) } if (f) { if (B.dropped) { B.dropped(a, D, b, c, d, e) } buildTree(D) } resetDnd(E); return false } function createClone(a) { $(a).remove(".easytree-expander"); var b = $(a).clone().remove(".easytree-expander").removeClass('easytree-drag-source')[0]; var c = b.children[0]; if (c && c.className == 'easytree-expander') { b.removeChild(c) } b.style.display = 'block'; b.style.position = "absolute"; b.style.opacity = 0.5; b.id = '_st_clone_'; b.style.zIndex = 1000; return b } function getDroppableTargetEl(a, b) { var c = document.elementFromPoint(a, b); while (c) { if (c.className.indexOf('easytree-droppable') > -1) { return c } c = c.parentElement } return null } function resetDnd(a) { a.canDrop = false; a.createClone = true; a.clone = null; a.dragok = false; a.openDelayTimeout = null; a.targetEl = null; a.targetId = null; a.targetNode = null; a.sourceEl = null; a.sourceId = null; a.sourceNode = null } function getElementId(a) { while (a != null) { if (a.id) { return a.id } a = a.parentElement } return null } function getNode(a, b) { var i = 0; for (i = 0; i < a.length; i++) { var n = a[i]; var t = n.text; if (n.id == b) { return n } var c = n.children && n.children.length > 0; if (c) { var d = getNode(n.children, b); if (d) { return d } } } return null } function isAncester(a, b) { var i = 0; if (!a || !a.children || a.children.length == 0) { return false } for (i = 0; i < a.children.length; i++) { var n = a.children[i]; var t = n.text; if (n.id == b) { return true } var c = n.children && n.children.length > 0; if (c) { var d = isAncester(n, b); if (d) { return d } } } return false } function removeNode(a, b) { var i = 0; for (i = 0; i < a.length; i++) { var n = a[i]; var t = n.text; if (n.id == b) { a.splice(i, 1); return } var c = n.children && n.children.length > 0; if (c) { removeNode(n.children, b) } } } function openCloseNode(a, b, c) { var i = 0; for (i = 0; i < a.length; i++) { var n = a[i]; var t = n.text; if (n.id == b) { n.isExpanded = c == "open"; return } var d = n.children && n.children.length > 0; if (d) { openCloseNode(n.children, b, c) } } } function unactivateAll(a) { var i = 0; for (i = 0; i < a.length; i++) { var n = a[i]; n.isActive = false; $('#' + n.id).removeClass('easytree-active'); var b = n.children && n.children.length > 0; if (b) { unactivateAll(n.children) } } } function unsourceAll(a) { var i = 0; for (i = 0; i < a.length; i++) { var n = a[i]; $('#' + n.id).removeClass('easytree-drag-source'); var b = n.children && n.children.length > 0; if (b) { unsourceAll(n.children) } } } function sort(f) { var i = 0; f = f.sort(function (a, b) { var c = a.text.toLowerCase(); var d = b.text.toLowerCase(); if (!c) { c = "a" } if (!d) { d = "a" } if (B.ordering.toLowerCase().indexOf('folder') > -1 && a.isFolder) { c = "______" + c } if (B.ordering.toLowerCase().indexOf('folder') > -1 && b.isFolder) { d = "______" + d } var e = B.ordering.indexOf(" DESC") == -1 ? 1 : -1; if (c < d) { return -1 * e } if (c > d) { return 1 * e } return 0 }); for (i = 0; i < f.length; i++) { var n = f[i]; var g = n.children && n.children.length > 0; if (g) { sort(n.children) } } return f } function giveUniqueIds(a, b, c) { var i = 0; if (!b) { b = 0; c = "_st_node_" + c + "_" } for (i = 0; i < a.length; i++) { var n = a[i]; if (!n.id) { n.id = c + i.toString() } var d = n.children && n.children.length > 0; if (d) { giveUniqueIds(n.children, b + 1, c + i + "_") } } } function buildTree(a) { if (!a) { return } var b = new Date(); if (B.building) { var c = B.building(a); if (c === false) { return false } } var d = new Date(); if (B.ordering) { a = sort(a) } var e = new Date(); var f = Math.floor(Math.random() * 10000); giveUniqueIds(a, 0, f); var g = new Date(); D = a; var h = getNodesAsHtml(a, 0, true); var i = new Date(); C[0].innerHTML = h; var k = new Date(); $(C.selector + " .easytree-node").on("click", a, nodeClick); $(C.selector + " .easytree-expander").on("click", a, toggleNodeEvt); $(C.selector + " .easytree-icon").on("dblclick", a, toggleNodeEvt); $(C.selector + " .easytree-title").on("dblclick", a, toggleNodeEvt); var l = new Date(); if (B.enableDnd) { $(document).on("mousedown", dragStart); $(document).on("mousemove", drag); $(document).on("mouseup", dragEnd) } var m = new Date(); if (B.built) { B.built(a) } var n = new Date(); if (B.stateChanged) { var j = getMinifiedJson(a); B.stateChanged(a, j) } var o = new Date(); var p = d - b; var q = e - d; var r = g - e; var s = i - g; var t = k - i; var u = l - k; var v = m - l; var w = n - m; var x = o - n; var y = o - b } function getNodesAsHtml(a, b, c) { var d = ''; var i = 0; var e = ""; if (b == 0) { e += "ui-easytree easytree-container easytree-focused" } var f = b < B.minOpenLevels; var g = b == 0 || c || f ? "" : " style='display:none' "; d += '<ul tabindex="0" class="' + e + '" ' + g + '">'; for (i = 0; i < a.length; i++) { var n = a[i]; if (f === true) { n.isExpanded = true } var h = i == a.length - 1; var j = getSpanCss(n, h); d += '<li>'; d += '<span id="' + n.id + '" class="' + j + ' ">'; d += f ? '' : '<span class="easytree-expander"></span>'; d += getIconHtml(n); d += getTitleHtml(n); d += '</span>'; if (n.children && n.children.length > 0) { d += getNodesAsHtml(n.children, b + 1, n.isExpanded) } d += '</li>' } d += '</ul>'; return d } function getSpanCss(a, b) { var c = a.children && a.children.length > 0; var d = "easytree-node "; if (B.enableDnd) { d += " easytree-draggable " } if (a.liClass) { d += a.liClass } if (a.isFolder && B.enableDnd) { d += " easytree-droppable easytree-accept " } else if (B.enableDnd) { d += " easytree-droppable easytree-reject " } if (a.isActive && B.allowActivate) { d += " easytree-active " } d += getExpCss(a, b); var e = a.isExpanded ? "e" : "c"; if (a.isFolder) { e += "f" } d += " easytree-ico-" + e; return d } function getExpCss(a, b) { var c = a.children && a.children.length > 0; var d = ""; if (!c && a.isLazy) { d = "c" } else if (!c) { d = "n" } else if (a.isExpanded) { d = "e" } else { d = "c" } if (b) { d += "l" } return " easytree-exp-" + d } function getIconHtml(a) { var b = ''; if (B.disableIcons) { return b } if (a.uiIcon) { return '<span class="easytree-custom-icon ui-icon ' + a.uiIcon + '"></span>' } if (a.iconUrl) { return '<span><img src="' + a.iconUrl + '" /></span>' } return '<span class="easytree-icon"></span>' } function getTitleHtml(a) { var b = ''; var c = a.tooltip ? 'title="' + a.tooltip + '"' : ""; var d = "easytree-title"; if (a.textCss) { d += " " + a.textCss } b += '<span ' + c + ' class="' + d + '">'; if (a.href) { b += '<a href="' + a.href + '" '; if (a.hrefTarget) { b += ' target="' + a.hrefTarget + '" ' } b += '>' } b += a.text; if (a.href) { b += '</a>' } b += '</span>'; return b } function renderNode(a, b) { if (!a) { return } var c = $('#' + a.id).attr('class'); var d = c.indexOf('easytree-exp-'); if (d > -1) { var e = c.indexOf(' ', d); var f = e > -1 ? c.substring(d, e) : c.substring(d); $('#' + a.id).removeClass(f); $('#' + a.id).addClass(getExpCss(a, false)) } var g = $('#' + a.id).parents('li').first(); var h = g.children('ul').first(); var i = parseInt(B.slidingTime, 10); if (b == "close") { h.slideUp(i) } else { h.slideDown(i) } } function hideDragHelpers() { $("#easytree-reject").hide(); $("#easytree-accept").hide() } function showAcceptDragHelper() { $("#easytree-accept").show(); $("#easytree-reject").hide() } function showRejectDragHelper() { $("#easytree-reject").show(); $("#easytree-accept").hide() } function getMinifiedJson(a) { var j = JSON.stringify ? JSON.stringify(a) : 'Please import json2.js'; while (j.indexOf(',"children":[]') > -1) { j = j.replace(',"children":[]', '') } while (j.indexOf('"liClass":"",') > -1) { j = j.replace('"liClass":"",', '') } while (j.indexOf('"textCss":"",') > -1) { j = j.replace('"textCss":"",', '') } while (j.indexOf('"isExpanded":false,') > -1) { j = j.replace('"isExpanded":false,', '') } while (j.indexOf('"isActive":false,') > -1) { j = j.replace('"isActive":false,', '') } while (j.indexOf('"isFolder":false,') > -1) { j = j.replace('"isFolder":false,', '') } while (j.indexOf('"isLazy":false,') > -1) { j = j.replace('"isLazy":false,', '') } return j } function init() { initDragHelpers(); resetDnd(E); $(document).on("mousemove", function (a) { var b = a.pageY; var c = a.pageX; document.getElementById('easytree-reject').style.top = (b + 10) + 'px'; document.getElementById('easytree-reject').style.left = (c + 17) + 'px'; document.getElementById('easytree-accept').style.top = (b + 10) + 'px'; document.getElementById('easytree-accept').style.left = (c + 17) + 'px' }) } function initDragHelpers() { if (!$("#easytree-reject").length) { var a = '<div id="easytree-reject" class="easytree-drag-helper easytree-drop-reject">'; a += '<span class="easytree-drag-helper-img"></span>'; a += '</div>'; $('body').append(a) } if (!$("#easytree-accept").length) { var b = '<div id="easytree-accept" class="easytree-drag-helper easytree-drop-accept">'; b += '<span class="easytree-drag-helper-img"></span>'; b += '</div>'; $('body').append(b) } } function ajaxService(d, e, f) { $.ajax({ url: d, type: "POST", contentType: "application/json; charset=utf-8", data: e, success: f, error: function (a, b, c) { alert("Error: " + a.responseText) } }) } function convertInputDataToJson(a) { var b = null; if (typeof a == 'object') { b = a } else if (typeof a == 'string') { a = $.trim(a); if (a.indexOf('[') == 0 || a.indexOf('{') == 0) { b = $.parseJSON(a) } else { b = convertHtmlToJson(a) } } return b } function convertHtmlToJson(b) { var i = 0; var c = $(b); var d = []; var e = c.children().each(function (a) { d.push(convertHtmlToNode(this)) }); return d } function convertHtmlToNode(b) { var c = $(b); var d = {}; var e = c.data(); d.isActive = c.hasClass('isActive'); c.removeClass('isActive'); d.isFolder = c.hasClass('isFolder'); c.removeClass('isFolder'); d.isExpanded = c.hasClass('isExpanded'); c.removeClass('isExpanded'); d.isLazy = c.hasClass('isLazy'); c.removeClass('isLazy'); d.uiIcon = e.uiicon; d.liClass = c.attr('class'); d.id = c.attr('id'); var f = c.children('a'); if (f) { d.href = f.attr('href'); d.hrefTarget = f.attr('target') } var g = c.children('img'); if (g) { d.iconUrl = g.attr('src') } d.textCss = ''; var h = c.children('span'); if (h && h.attr('class')) { d.textCss += h.attr('class') + ' ' } h = f.children('span'); if (h && h.attr('class')) { d.textCss += h.attr('class') + ' ' } h = g.children('span'); if (h && h.attr('class')) { d.textCss += h.attr('class') + ' ' } d.text = getNodeValue(c[0]); d.tooltip = c.attr('title'); d.children = []; var i = c.children('ul').children('li').each(function (a) { d.children.push(convertHtmlToNode(this)) }); return d } function getNodeValue(a) { var i = 0; for (i = 0; i < a.childNodes.length; i++) { var b = a.childNodes[i]; while (b) { if (b.nodeType == 3 && $.trim(b.nodeValue).length > 0) { return $.trim(b.nodeValue) } b = b.firstChild } } return '' } this.init(z, A); function log(a) { if (!a) { a = 'null' } console.log(a) } } }(jQuery));
/*!
 * jQuery EasyTree Plugin
 * http://www.EasyJsTree.com
 *
 * Copyright 2014 Matthew Rand
 * Released under the MIT license
 * V1.0.1
 */



(function ($) {

    $.fn.easytree = function (options) {
        var jQueryContext = this;
        var easyTree = new EasyTree(jQueryContext, options);

        return easyTree;
    };

    /* Example node */
    // var node = {}
    // node.children = [];
    // node.isActive = false;
    // node.isFolder = false;
    // node.isExpanded = false;
    // node.isLazy = false;
    // node.iconUrl = '';
    // node.id = '';
    // node.href = '';
    // node.hrefTarget = '';
    // node.lazyUrl = '';
    // node.lazyUrlJson = '';
    // node.liClass = '';
    // node.text = '';
    // node.textCss = '';
    // node.tooltip = '';
    // node.uiIcon = '';

    var EasyTree = function (jQueryContext, options) {

        var _settings = {
            allowActivate: true,
            data: null,
            dataUrl: null,
            dataUrlJson: null,
            disableIcons: false,
            enableDnd: false, // drag 'n' drop
            ordering: null, // ordered || orderedFolder
            slidingTime: 100,
            minOpenLevels: 0,

            // events
            building: null,
            built: null,
            toggling: null,
            toggled: null,
            opening: null,
            opened: null,
            openLazyNode: null,
            closing: null,
            closed: null,
            canDrop: null,
            dropping: null,
            dropped: null,
            stateChanged: null
        };

        var $this;
        var _nodes = null;
        var _dnd = new Object(); // initiate internal dnd helper object

        this.init = function (jQueryContext, options) {

            _settings = $.extend(_settings, options);

            init();

            $this = jQueryContext;

            var json = '';
            if (_settings.dataUrl) {
                ajaxService(_settings.dataUrl, _settings.dataUrlJson, function (data) {
                    json = convertInputDataToJson(data);
                    if (!json) {
                        alert("EasyTree: Invalid data!");
                        return this;
                    }
                    buildTree(json);
                    return this;
                });
            }
            else if (_settings.data) {
                json = convertInputDataToJson(_settings.data);
                if (!json) {
                    alert("EasyTree: Invalid data!");
                    return this;
                }
                buildTree(json);
            }
            else {
                json = convertInputDataToJson($this.html());
                if (!json) {
                    alert("EasyTree: Invalid data!");
                    return this;
                }
                buildTree(json);
            }

            return this;
        };

        //public helpers
        this.options = _settings;
        this.rebuildTree = function (data) {
            var json = data ? convertInputDataToJson(data) : _nodes;
            if (!json) {
                alert("EasyTree: Invalid data!");
            }
            buildTree(json);
        };
        this.getAllNodes = function () {
            return _nodes;
        };
        this.getNode = function (id) {
            return getNode(_nodes, id);
        };
        this.addNode = function (sourceNode, targetId) {

            if (!targetId) { // if blank targetId add to root node
                _nodes.push(sourceNode);
                return;
            }

            var targetNode = getNode(_nodes, targetId);

            if (!sourceNode) {
                return;
            }

            if (!targetNode.children) {
                targetNode.children = [];
            }

            targetNode.children.push(sourceNode);
        };
        this.removeNode = function (id) {
            removeNode(_nodes, id);
        };
        this.activateNode = function (id) {
            unactivateAll(_nodes);

            if (!_settings.allowActivate) {
                return;
            }

            var node = getNode(_nodes, id);
            if (!node) { return; }

            node.isActive = true;
            $('#' + node.id).addClass('easytree-active');
        };
        this.toggleNode = function (id) {
            var node = getNode(_nodes, id);
            if (!node) { return; }

            toggleNodeBegin(event, _nodes, node);
        };

        // events
        function nodeClick(event) {
            var id = getElementId(this);
            var nodes = event.data;
            var node = getNode(nodes, id);
            if (!node) { return; }

            unactivateAll(nodes);

            if (!_settings.allowActivate) {
                return;
            }

            node.isActive = true;
            $('#' + node.id).addClass('easytree-active');

            if (_settings.stateChanged) { // fire stateChanged event
                var j = getMinifiedJson(nodes);
                _settings.stateChanged(nodes, j);
            }
        }
        function toggleNodeEvt(event) {
            var id = getElementId(this);
            var nodes = event.data;
            var node = getNode(nodes, id);
            if (!node) { return; }

            toggleNodeBegin(event, nodes, node);
        }

        function toggleNodeBegin(event, nodes, node) {
            var ret = ''; // return value of event
            if (_settings.toggling) { // fire toggling event
                ret = _settings.toggling(event, nodes, node);
                if (ret === false) {
                    return false;
                }
            }

            if (node.isExpanded) { // if closing node
                if (_settings.closing) { // fire closing event
                    ret = _settings.closing(event, nodes, node);
                    if (ret === false) {
                        return false;
                    }
                }
            }
            else { // if opening node
                if (_settings.opening) { // fire opening event
                    ret = _settings.opening(event, nodes, node);
                    if (ret === false) {
                        return false;
                    }
                }
            }

            if (node.isLazy && !node.isExpanded) { // if opening a lazy node 
                var hasChildren = node.children && node.children.length > 0;
                ret = true;
                if (_settings.openLazyNode) { // fire openLazyNode event
                    ret = _settings.openLazyNode(event, nodes, node, hasChildren);
                }
                if (node.lazyUrl && ret !== false) {
                    ajaxService(node.lazyUrl, node.lazyUrlJson, function (data) {
                        if (data.d) {
                            data = data.d;
                        }

                        var json = convertInputDataToJson(data);
                        if ($.isArray(json)) {
                            node.children = json;
                        }
                        else {
                            node.children = [];
                            node.children.push(json);
                        }

                        buildTree(nodes);
                        toggleNodeEnd(event, nodes, node);
                    });

                    return false;
                }
            }

            toggleNodeEnd(event, nodes, node);
        }
        function toggleNodeEnd(event, nodes, node) {
            if (node.isExpanded) { // if closing node
                openCloseNode(nodes, node.id, "close");
                renderNode(node, "close");

                if (_settings.closed) { // fire closed event
                    _settings.closed(event, nodes, node);
                }
            }
            else { // if opening node
                openCloseNode(nodes, node.id, "open");
                renderNode(node, "open");

                if (_settings.opened) { // fire opened event
                    _settings.opened(event, nodes, node);
                }
            }

            if (_settings.toggled) { // fire toggled event
                var ret = _settings.toggled(event, nodes, node);
            }
        }

        // dnd
        function dragStart(event) {
            if (!_settings.enableDnd) { return; }

            var el = event.target;
            while (el) {
                if (el.className.indexOf("easytree-draggable") > -1) {
                    break;
                }
                el = el.parentElement;
            }

            if (!el) { return; } // not draggable, no 'easytree-draggable' class found

            unsourceAll(_nodes);
            unactivateAll(_nodes);
            $('#' + el.id).addClass('easytree-drag-source');

            resetDnd(_dnd);
            _dnd.createClone = !(el.className.indexOf("easytree-no-clone") > -1);
            _dnd.dragok = true;
            _dnd.sourceEl = el;
            _dnd.sourceId = el.id;
            _dnd.sourceNode = getNode(_nodes, _dnd.sourceId);

            return false;
        }
        function drag(event) {
            if (!_dnd.dragok) { return; }
            if (!_settings.enableDnd) { return; }

            if (_dnd.createClone) {
                if (!_dnd.clone) {
                    _dnd.clone = createClone(_dnd.sourceEl);
                    $(_dnd.clone).appendTo('body');
                }

                _dnd.clone.style.left = (event.pageX + 5) + "px";
                _dnd.clone.style.top = (event.pageY) + "px";
            }

            var targetEl = getDroppableTargetEl(event.clientX, event.clientY);
            if (!targetEl) {
                hideDragHelpers();
                _dnd.targetEl = null;
                _dnd.targetId = null;
                _dnd.targetNode = null;
                _dnd.canDrop = false;
                return;
            }
            if (targetEl.id == _dnd.targetId) { // return if drag target hasn't changed
                return;
            }

            _dnd.canDrop = false; // assume false unless explicitly true

            window.clearTimeout(_dnd.openDelayTimeout);

            _dnd.targetEl = targetEl;
            _dnd.targetId = targetEl.id;
            _dnd.targetNode = getNode(_nodes, _dnd.targetId);

            log('source:' + (_dnd.sourceNode && _dnd.sourceNode.text ? _dnd.sourceNode.text : _dnd.sourceId));
            log('target:' + (_dnd.targetNode && _dnd.targetNode.text ? _dnd.targetNode.text : _dnd.targetId));
            log('isAncester:' + isAncester(_dnd.sourceNode, _dnd.targetId));

            var $target = $('#' + _dnd.targetId);

            if (isAncester(_dnd.sourceNode, _dnd.targetId)) { // don't allow drops to ancesters
                showRejectDragHelper();
                return;
            }
            if (_dnd.targetId == _dnd.sourceId) { // don't allow drops to self
                hideDragHelpers();
                return;
            }

            if (_settings.canDrop) {
                var isSourceNode = _dnd.sourceNode != null;
                var source = isSourceNode ? _dnd.sourceNode : _dnd.sourceEl;
                var isTargetNode = _dnd.targetNode != null;
                var target = isTargetNode ? _dnd.targetNode : _dnd.targetEl;

                var ret = _settings.canDrop(event, _nodes, isSourceNode, source, isTargetNode, target);
                if (ret === true) { // user forces accept
                    showAcceptDragHelper();
                    _dnd.canDrop = true;
                    _dnd.openDelayTimeout = window.setTimeout(function () {
                        openCloseNode(_nodes, _dnd.targetId, 'open');
                        renderNode(_dnd.targetNode, 'open');
                    }, 600);
                    return;
                }
                else if (ret === false) { // user forces reject
                    showRejectDragHelper();
                    return;
                }
            }

            if ($target.hasClass('easytree-reject')) {
                showRejectDragHelper();
            }
            else if ($target.hasClass('easytree-accept')) {
                showAcceptDragHelper();
                _dnd.canDrop = true;
                _dnd.openDelayTimeout = window.setTimeout(function () {
                    openCloseNode(_nodes, _dnd.targetId, 'open');
                    renderNode(_dnd.targetNode, 'open');
                }, 600);
            }
            else {
                hideDragHelpers();
            }

            return false;
        }
        function dragEnd(event) {
            // define variables to send in events
            var isSourceNode = _dnd.sourceNode != null;
            var source = isSourceNode ? _dnd.sourceNode : _dnd.sourceEl;
            var isTargetNode = _dnd.targetNode != null;
            var target = isTargetNode ? _dnd.targetNode : _dnd.targetEl;
            var canDrop = _dnd.canDrop;

            hideDragHelpers();
            $('#_st_clone_').remove();
            // $(document).off("mousemove", "**");

            if (source === null || target === null) {
                resetDnd(_dnd);
                return false;
            }

            if (_settings.dropping) { // fire dropping event
                var ret = _settings.dropping(event, _nodes, isSourceNode, source, isTargetNode, target, canDrop);
                if (ret === false) {
                    resetDnd(_dnd);
                    return;
                }
            }            

            if (_dnd.targetNode && _dnd.sourceNode && canDrop) { // internal drop
                if (!_dnd.targetNode.children) {
                    _dnd.targetNode.children = [];
                }

                removeNode(_nodes, _dnd.sourceId);
                _dnd.targetNode.children.push(_dnd.sourceNode);
            }

            if (canDrop) {
                if (_settings.dropped) { // fire dropped event
                    _settings.dropped(event, _nodes, isSourceNode, source, isTargetNode, target);
                }
                buildTree(_nodes);
            }

            resetDnd(_dnd);

            return false;
        }
        function createClone(sourceEl) {
            $(sourceEl).remove(".easytree-expander");
            var clone = $(sourceEl).clone().remove(".easytree-expander").removeClass('easytree-drag-source')[0];
            var firstChild = clone.children[0];
            if (firstChild && firstChild.className == 'easytree-expander') {
                clone.removeChild(firstChild);
            }
            clone.style.display = 'block';
            clone.style.position = "absolute";
            clone.style.opacity = 0.5;
            clone.id = '_st_clone_';
            clone.style.zIndex = 1000;

            return clone;
        }
        function getDroppableTargetEl(clientX, clientY) {
            var targetEl = document.elementFromPoint(clientX, clientY);

            while (targetEl) {
                if (targetEl.className.indexOf('easytree-droppable') > -1) {
                    return targetEl;
                }
                targetEl = targetEl.parentElement;
            }

            return null;
        }
        function resetDnd(dnd) {
            dnd.canDrop = false;
            dnd.createClone = true;
            dnd.clone = null;
            dnd.dragok = false;
            dnd.openDelayTimeout = null;
            dnd.targetEl = null;
            dnd.targetId = null;
            dnd.targetNode = null;
            dnd.sourceEl = null;
            dnd.sourceId = null;
            dnd.sourceNode = null;
        }

        // tree manipulation
        function getElementId(el) {
            while (el != null) {
                if (el.id) {
                    return el.id;
                }
                el = el.parentElement;
            }
            return null;
        }
        function getNode(nodes, id) {
            var i = 0;
            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];
                var t = n.text;
                if (n.id == id) {
                    return n;
                }
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    var node = getNode(n.children, id);
                    if (node) {
                        return node;
                    }
                }
            }

            return null;
        }
        function isAncester(node, id) {
            var i = 0;
            if (!node || !node.children || node.children.length == 0) {
                return false;
            }
            for (i = 0; i < node.children.length; i++) {
                var n = node.children[i];
                var t = n.text;
                if (n.id == id) {
                    return true;
                }
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    var ancester = isAncester(n, id);
                    if (ancester) {  // if true
                        return ancester;
                    }
                }
            }

            return false;
        }
        function removeNode(nodes, id) {
            var i = 0;
            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];
                var t = n.text;
                if (n.id == id) {
                    nodes.splice(i, 1);
                    return;
                }
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    removeNode(n.children, id);
                }
            }
        }
        function openCloseNode(nodes, id, openOrClose) {
            var i = 0;
            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];
                var t = n.text;
                if (n.id == id) {
                    n.isExpanded = openOrClose == "open";
                    return;
                }
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    openCloseNode(n.children, id, openOrClose);
                }
            }
        }
        function unactivateAll(nodes) {
            var i = 0;
            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];
                n.isActive = false;
                $('#' + n.id).removeClass('easytree-active');
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    unactivateAll(n.children);
                }
            }
        }
        function unsourceAll(nodes) {
            var i = 0;
            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];
                $('#' + n.id).removeClass('easytree-drag-source');
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    unsourceAll(n.children);
                }
            }
        }
        function sort(nodes) {
            var i = 0;

            nodes = nodes.sort(function (n1, n2) {
                var n1Text = n1.text.toLowerCase();
                var n2Text = n2.text.toLowerCase();
                if (!n1Text) { n1Text = "a"; } // take into account empty text, so it is below folders
                if (!n2Text) { n2Text = "a"; }

                if (_settings.ordering.toLowerCase().indexOf('folder') > -1 && n1.isFolder) {
                    n1Text = "______" + n1Text;
                }
                if (_settings.ordering.toLowerCase().indexOf('folder') > -1 && n2.isFolder) {
                    n2Text = "______" + n2Text;
                }
                var reverse = _settings.ordering.indexOf(" DESC") == -1 ? 1 : -1;
                if (n1Text < n2Text) { //sort string ascending
                    return -1 * reverse;
                }
                if (n1Text > n2Text) {
                    return 1 * reverse;
                }
                return 0;//default return value (no sorting)
            });

            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    sort(n.children);
                }
            }

            return nodes;
        }
        function giveUniqueIds(nodes, level, id) {
            var i = 0;
            if (!level) {
                level = 0;
                id = "_st_node_" + id + "_";
            }
            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];

                if (!n.id) { // if no id so generate one //  || n.id.indexOf('_st_node_') == 0
                    n.id = id + i.toString();
                }
                var hasChildren = n.children && n.children.length > 0;
                if (hasChildren) {
                    giveUniqueIds(n.children, level + 1, id + i + "_");
                }
            }
        }

        // rendering
        function buildTree(nodes) {
            if (!nodes) { return; }

            var s1 = new Date();

            if (_settings.building) { // fire building event
                var ret = _settings.building(nodes);
                if (ret === false) {
                    return false;
                }
            }

            var s2 = new Date();

            if (_settings.ordering) {
                nodes = sort(nodes);
            }

            var s3 = new Date();

            var uniqueId = Math.floor(Math.random() * 10000);
            giveUniqueIds(nodes, 0, uniqueId);

            var s4 = new Date();

            _nodes = nodes; // global _nodes used to give public access
            var html = getNodesAsHtml(nodes, 0, true);

            var s5 = new Date();

            $this[0].innerHTML = html;

            var s6 = new Date();

            $($this.selector + " .easytree-node").on("click", nodes, nodeClick);
            $($this.selector + " .easytree-expander").on("click", nodes, toggleNodeEvt);
            $($this.selector + " .easytree-icon").on("dblclick", nodes, toggleNodeEvt);
            $($this.selector + " .easytree-title").on("dblclick", nodes, toggleNodeEvt);

            var s7 = new Date();

            if (_settings.enableDnd) {
                $(document).on("mousedown", dragStart);
                $(document).on("mousemove", drag);
                $(document).on("mouseup", dragEnd);
            }

            var s8 = new Date();

            if (_settings.built) { // fire built event
                _settings.built(nodes);
            }

            var s9 = new Date();

            if (_settings.stateChanged) { // fire stateChanged event
                var j = getMinifiedJson(nodes);
                _settings.stateChanged(nodes, j);
            }

            var s10 = new Date();


            var t1 = s2 - s1;
            var t2 = s3 - s2;
            var t3 = s4 - s3;
            var t4 = s5 - s4;
            var t5 = s6 - s5;
            var t6 = s7 - s6;
            var t7 = s8 - s7;
            var t8 = s9 - s8;
            var t9 = s10 - s9;
            var total = s10 - s1;
        }
        function getNodesAsHtml(nodes, level, display) {
            var html = '';
            var i = 0;

            var ulCss = "";
            if (level == 0) {
                ulCss += "ui-easytree easytree-container easytree-focused";
            }

            var forceOpenNode = level < _settings.minOpenLevels;

            var ulStyle = level == 0 || display || forceOpenNode ? "" : " style='display:none' ";
            html += '<ul tabindex="0" class="' + ulCss + '" ' + ulStyle + '">';

            for (i = 0; i < nodes.length; i++) {
                var n = nodes[i];

                if (forceOpenNode === true) {
                    n.isExpanded = true;
                }

                var lastSibling = i == nodes.length - 1;
                var spanCss = getSpanCss(n, lastSibling);

                html += '<li>';
                html += '<span id="' + n.id + '" class="' + spanCss + ' ">'; // wrapper span
                html += forceOpenNode ? '' : '<span class="easytree-expander"></span>';

                html += getIconHtml(n);
                html += getTitleHtml(n);

                html += '</span>'; // end wrapper span

                if (n.children && n.children.length > 0) { // if has children
                    html += getNodesAsHtml(n.children, level + 1, n.isExpanded);
                }

                html += '</li>';

            }
            html += '</ul>';

            return html;
        }
        function getSpanCss(node, lastSibling) {
            var hasChildren = node.children && node.children.length > 0;
            var spanCss = "easytree-node ";
            if (_settings.enableDnd) {
                spanCss += " easytree-draggable ";
            }
            if (node.liClass) {
                spanCss += node.liClass;
            }
            if (node.isFolder && _settings.enableDnd) {
                spanCss += " easytree-droppable easytree-accept ";
            }
            else if (_settings.enableDnd) {
                spanCss += " easytree-droppable easytree-reject ";
            }

            if (node.isActive && _settings.allowActivate) {
                spanCss += " easytree-active ";
            }

            spanCss += getExpCss(node, lastSibling);

            var ico = node.isExpanded ? "e" : "c";
            if (node.isFolder) {
                ico += "f";
            }
            spanCss += " easytree-ico-" + ico;

            return spanCss;
        }
        function getExpCss(node, lastSibling) {
            var hasChildren = node.children && node.children.length > 0;
            var exp = "";
            if (!hasChildren && node.isLazy) {
                exp = "c";
            }
            else if (!hasChildren) {
                exp = "n";
            }
            else if (node.isExpanded) {
                exp = "e";
            }
            else {
                exp = "c";
            }
            //exp = !hasChildren ? "n" : node.isExpanded ? "e" : "c";
            if (lastSibling) {
                exp += "l";
            }

            return " easytree-exp-" + exp;
        }
        function getIconHtml(node) {
            var html = '';
            if (_settings.disableIcons) {
                return html;
            }
            if (node.uiIcon) {
                return '<span class="easytree-custom-icon ui-icon ' + node.uiIcon + '"></span>';
            }
            if (node.iconUrl) {
                return '<span><img src="' + node.iconUrl + '" /></span>';
            }

            return '<span class="easytree-icon"></span>';
        }
        function getTitleHtml(node) {
            var html = '';
            var tooltip = node.tooltip ? 'title="' + node.tooltip + '"' : "";

            var titleCss = "easytree-title";
            if (node.textCss) {
                titleCss += " " + node.textCss;
            }

            html += '<span ' + tooltip + ' class="' + titleCss + '">';

            if (node.href) {
                html += '<a href="' + node.href + '" ';
                if (node.hrefTarget) {
                    html += ' target="' + node.hrefTarget + '" ';
                }
                html += '>';
            }
            html += node.text;
            if (node.href) {
                html += '</a>';
            }
            html += '</span>';

            return html;
        }
        function renderNode(node, openOrClose) {
            if (!node) { return; }
            var classes = $('#' + node.id).attr('class');

            var expClassStart = classes.indexOf('easytree-exp-');
            if (expClassStart > -1) { // change arrow/expander class
                var expClassEnd = classes.indexOf(' ', expClassStart);
                var expClass = expClassEnd > -1 ? classes.substring(expClassStart, expClassEnd) : classes.substring(expClassStart);
                $('#' + node.id).removeClass(expClass);
                $('#' + node.id).addClass(getExpCss(node, false));
            }

            var parentLi = $('#' + node.id).parents('li').first();
            var childUl = parentLi.children('ul').first();

            var slideTime = parseInt(_settings.slidingTime, 10);
            if (openOrClose == "close") {
                childUl.slideUp(slideTime);
            }
            else {
                childUl.slideDown(slideTime);
            }
        }

        // helpers
        function hideDragHelpers() {
            $("#easytree-reject").hide();
            $("#easytree-accept").hide();
        }
        function showAcceptDragHelper() {
            $("#easytree-accept").show();
            $("#easytree-reject").hide();

        }
        function showRejectDragHelper() {
            $("#easytree-reject").show();
            $("#easytree-accept").hide();
        }
        function getMinifiedJson(nodes) { // to increase the chance it can be stored in a 4kb cookie
            var j = JSON.stringify ? JSON.stringify(nodes) : 'Please import json2.js'; // for IE6/7 please import json2.js
            while (j.indexOf(',"children":[]') > -1) {
                j = j.replace(',"children":[]', '');
            }
            while (j.indexOf('"liClass":"",') > -1) {
                j = j.replace('"liClass":"",', '');
            }
            while (j.indexOf('"textCss":"",') > -1) {
                j = j.replace('"textCss":"",', '');
            }
            while (j.indexOf('"isExpanded":false,') > -1) {
                j = j.replace('"isExpanded":false,', '');
            }
            while (j.indexOf('"isActive":false,') > -1) {
                j = j.replace('"isActive":false,', '');
            }
            while (j.indexOf('"isFolder":false,') > -1) {
                j = j.replace('"isFolder":false,', '');
            }
            while (j.indexOf('"isLazy":false,') > -1) {
                j = j.replace('"isLazy":false,', '');
            }

            return j;
        }

        // initialisation
        function init() {
            initDragHelpers();
            resetDnd(_dnd);
            $(document).on("mousemove", function (event) {
                var top = event.pageY;
                var left = event.pageX;

                document.getElementById('easytree-reject').style.top = (top + 10) + 'px';
                document.getElementById('easytree-reject').style.left = (left + 17) + 'px';
                document.getElementById('easytree-accept').style.top = (top + 10) + 'px';
                document.getElementById('easytree-accept').style.left = (left + 17) + 'px';
            });
        }
        function initDragHelpers() {
            if (!$("#easytree-reject").length) {
                var dragRejectHtml = '<div id="easytree-reject" class="easytree-drag-helper easytree-drop-reject">';
                dragRejectHtml += '<span class="easytree-drag-helper-img"></span>';
                dragRejectHtml += '</div>';

                $('body').append(dragRejectHtml);
            }
            if (!$("#easytree-accept").length) {
                var dragAcceptHtml = '<div id="easytree-accept" class="easytree-drag-helper easytree-drop-accept">';
                dragAcceptHtml += '<span class="easytree-drag-helper-img"></span>';
                dragAcceptHtml += '</div>';

                $('body').append(dragAcceptHtml);
            }
        }
        function ajaxService(actionUrl, json, callBack) {
            $.ajax({
                url: actionUrl,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: json,
                success: callBack,
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error: " + jqXHR.responseText);
                }
            });
        }
        function convertInputDataToJson(data) {
            var json = null;
            if (typeof data == 'object') {
                json = data;
            }
            else if (typeof data == 'string') {
                data = $.trim(data);
                if (data.indexOf('[') == 0 || data.indexOf('{') == 0) // assume json
                {
                    json = $.parseJSON(data);
                }
                else {
                    json = convertHtmlToJson(data); // parse html in json object
                }
            }

            return json;
        }
        function convertHtmlToJson(html) {
            var i = 0;
            var $html = $(html);
            var nodes = [];
            var children = $html.children().each(function (index) {
                nodes.push(convertHtmlToNode(this));
            });

            return nodes;
        }
        function convertHtmlToNode(element) {
            var $el = $(element);
            var node = {};
            var data = $el.data();

            node.isActive = $el.hasClass('isActive');
            $el.removeClass('isActive');
            node.isFolder = $el.hasClass('isFolder');
            $el.removeClass('isFolder');
            node.isExpanded = $el.hasClass('isExpanded');
            $el.removeClass('isExpanded');
            node.isLazy = $el.hasClass('isLazy');
            $el.removeClass('isLazy');

            node.uiIcon = data.uiicon;
            node.liClass = $el.attr('class');
            node.id = $el.attr('id');

            var $a = $el.children('a');
            if ($a) {
                node.href = $a.attr('href');
                node.hrefTarget = $a.attr('target');
            }

            var $img = $el.children('img');
            if ($img) {
                node.iconUrl = $img.attr('src');
            }

            node.textCss = '';
            var $span = $el.children('span');
            if ($span && $span.attr('class')) {
                node.textCss += $span.attr('class') + ' ';
            }
            $span = $a.children('span');
            if ($span && $span.attr('class')) {
                node.textCss += $span.attr('class') + ' ';
            }
            $span = $img.children('span');
            if ($span && $span.attr('class')) {
                node.textCss += $span.attr('class') + ' ';
            }

            node.text = getNodeValue($el[0]);//$.trim($el.first().text());
            node.tooltip = $el.attr('title');

            node.children = [];
            var $li = $el.children('ul').children('li').each(function (index) {
                node.children.push(convertHtmlToNode(this));
            });

            return node;
        }
        function getNodeValue(el) {
            var i = 0;
            for (i = 0; i < el.childNodes.length; i++) {
                var child = el.childNodes[i];
                while (child) {
                    if (child.nodeType == 3 && $.trim(child.nodeValue).length > 0) {
                        return $.trim(child.nodeValue);
                    }
                    child = child.firstChild;
                }
            }
            return '';
        }
        this.init(jQueryContext, options);

        // other
        function log(message) {
            if (!message) {
                message = 'null';
            }
            console.log(message);
        }

    }
}(jQuery));
//Agrega los archivos básicos para el menú de árbol.


