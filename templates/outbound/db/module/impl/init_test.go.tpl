package impl

import (
	"testing"
	"github.com/stretchr/testify/assert"
	"gorm.io/gorm"
	"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
)

func TestNew(t *testing.T) {
	db := &gorm.DB{}
	repo := New(db)
	assert.NotNil(t, repo)
	_, ok := repo.({{.ModuleNameLower}}.Repository)
	assert.True(t, ok)
}
