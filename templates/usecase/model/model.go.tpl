package model


type (
	{{.ModuleName}} struct {
		ID      string
		Name      string
	}
	Get{{.ModuleName}}Request struct {
		Search     string
		Page       int
		Limit      int
		OrderField string
	}
	Update{{.ModuleName}}Request struct {
		Name string
	}
	Create{{.ModuleName}}Request struct {
        ID string
		Name string
    }
)
