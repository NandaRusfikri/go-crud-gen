package impl

import (
	"context"
	"errors"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	mockrepo"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
)

func TestDelete(t *testing.T) {
	ctx := context.Background()

	tests := []struct {
		name        string
		id          uint64
		setupMock   func(m *mockrepo.Mock{{.ModuleName}}Repository)
		expectedErr error
	}{
		{
			name: "Positive case",
			id:   1,
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("Delete", mock.Anything, uint64(1)).Return(nil)
			},
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			id:   1,
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("Delete", mock.Anything, uint64(1)).Return(errors.New("database error"))
			},
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			tt.setupMock(mockRepo)

			err := mockRepo.Delete(ctx, tt.id)

			assert.Equal(t, tt.expectedErr, err)
			mockRepo.AssertExpectations(t)
		})
	}
}
