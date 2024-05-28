package impl

import (
	"context"
	"errors"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	mockrepo"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
)

func TestUpdate(t *testing.T) {
	ctx := context.Background()

	tests := []struct {
		name        string
		input       model.Table{{.ModuleName}}
		setupMock   func(m *mockrepo.Mock{{.ModuleName}}Repository)
		expected    model.Table{{.ModuleName}}
		expectedErr error
	}{
		{
			name: "Positive case",
			input: model.Table{{.ModuleName}}{
				ID:   1,
				Name: "Updated {{.ModuleName}}",
			},
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("Update", mock.Anything, mock.AnythingOfType("model.Table{{.ModuleName}}")).Return(model.Table{{.ModuleName}}{ID: 1, Name: "Updated {{.ModuleName}}"}, nil)
			},
			expected:    model.Table{{.ModuleName}}{ID: 1, Name: "Updated {{.ModuleName}}"},
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			input: model.Table{{.ModuleName}}{
				ID:   1,
				Name: "Updated {{.ModuleName}}",
			},
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("Update", mock.Anything, mock.AnythingOfType("model.Table{{.ModuleName}}")).Return(model.Table{{.ModuleName}}{}, errors.New("database error"))
			},
			expected:    model.Table{{.ModuleName}}{},
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			tt.setupMock(mockRepo)

			res, err := mockRepo.Update(ctx, tt.input)

			assert.Equal(t, tt.expectedErr, err)
			assert.Equal(t, tt.expected, res)
			mockRepo.AssertExpectations(t)
		})
	}
}