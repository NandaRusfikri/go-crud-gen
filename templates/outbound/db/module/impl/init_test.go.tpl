package impl

import (
	"testing"
	"github.com/stretchr/testify/assert"
	"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
	"{{.ModuleNameRoot}}/pkg/resource/model"
)

func TestNew(t *testing.T) {
	repo := New(model.Database{})
	assert.NotNil(t, repo)
	_, ok := repo.({{.ModuleNameLower}}.Repository)
	assert.True(t, ok)
}
