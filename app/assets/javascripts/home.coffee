index_home=avalon.define
    input:
        PageIndex: 1
        PageSize: 5
    $id:'index_home'
    data:[]
    getData:->
        vm=this
        $.post '/home/_getIndexPageData',vm.input,(data)-> 
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
index_home.$watch 'onReady',->
    vm=this
    vm.getData()