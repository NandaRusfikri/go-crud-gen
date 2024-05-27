package model

import (
    "time"
)

// Table{{.ModuleName}} represents the structure of the {{.ModuleName}} table in the database.
type (
    Table{{.ModuleName}} struct {
        ID        uint64       `gorm:"primary_key;auto_increment"`
        // Add your fields here, e.g.,
        Name      string    `gorm:"type:varchar(100)" `
        CreatedAt time.Time `gorm:"column:created_at;default:now()" `
        UpdatedAt time.Time `gorm:"column:created_at;default:now()"`
    }

    GetList{{.ModuleName}}Request struct {
	    Search     string
	    Page       int
	    Limit      int
	    OrderField string
    }

)


