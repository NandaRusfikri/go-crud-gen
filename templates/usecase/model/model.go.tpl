package model

type (
	{{.ModuleName}} struct {
		ID      uint64
		Name      string
	}
	Get{{.ModuleName}}Request struct {
		Search     string
		Page       int
		Limit      int
		OrderField string
	}
	Update{{.ModuleName}}Request struct {
	    ID uint64
		Name string
	}
	Create{{.ModuleName}}Request struct {
		Name string
    }

    List{{.ModuleName}}Response struct {
    	Count       int64
    	PageCurrent int
    	PageTotal   int
    	{{.ModuleName}}s       []{{.ModuleName}}
    }
)
