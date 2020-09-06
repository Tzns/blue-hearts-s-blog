word_back=avalon.define
    input:
        PageIndex: 1
        PageSize: 10
        key: ""
    $id:'word_back'
    data:[]
    getData:->
        vm=this
        $.post '/back/_getDataPageData',vm.input,(data)-> 
            if data.IsSuccess
                pageOptions.totalPages = data.Data.PageCount
                pageOptions.currentPage = data.Data.PageIndex
                pageOptions.onPageClicked = (a, b, c, p)->  
                    vm.input.PageIndex = p
                    vm.getData()
                $('#example').bootstrapPaginator(pageOptions)
                vm.data=data.Data.Data
            else
                alert data.Info
    add_update:
        title:""
        type:""
        input:
            title:""
            content:""
        add:->
            vm=this
            vm.title="添加"
            vm.type="insert"
            vm.input.title=""
            vm.input.content=""
            $('#word_add_update_box').modal 'show'
        update:(s)->
            vm=this
            vm.title="修改"
            vm.type="update"
            vm.input.title=s.title
            vm.input.content=s.word_content
            vm.input.id=s.id
            $('#word_add_update_box').modal 'show'
        del:(s)->
            vm=this
            if confirm("确认删除吗")
                $.post "/back/_del_blog",s,(data)->
                    if data.IsSuccess
                        word_back.getData()
                    else
                        alert(data.Info)
        submit:->
            vm=this
            $.post "/back/_#{vm.type}_blog",vm.input,(data)->
                if data.IsSuccess
                    word_back.getData()
                    $('#word_add_update_box').modal 'hide'
                alert(data.Info)
word_back.$watch 'onReady',->
    vm=this
    vm.getData()
    
       
    $('#word_add_update_box').on 'shown.bs.modal', (e)->
        options=Object.create(edit_options)
        if vm.add_update.input.content!=""
            options.markdown=vm.add_update.input.content
        edit=editormd "word_editor",options
        $(".editormd-preview-close-btn").hide()
    return false