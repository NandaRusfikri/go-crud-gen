package impl

import (
	"context"
	"errors"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/require"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	mockrepo"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
)

func TestCreate(t *testing.T) {
	ctx := context.Background()

	tests := []struct {
		name        string
		input       *model.Table{{.ModuleName}}
		setupMock   func(m *mockrepo.Mock{{.ModuleName}}Repository)
		expectedErr error
		expectedID  uint64
	}{
		{
			name: "Positive case",
			input: &model.Table{{.ModuleName}}{
				Name: "Test Name",
			},
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("Create", mock.Anything, mock.AnythingOfType("*model.Table{{.ModuleName}}")).Return(nil).Run(func(args mock.Arguments) {
					arg := args.Get(1).(*model.Table{{.ModuleName}})
					arg.ID = 1
				})
			},
			expectedErr: nil,
			expectedID:  1,
		},
		{
			name: "Negative case with database error",
			input: &model.Table{{.ModuleName}}{
				Name: "Test Name",
			},
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("Create", mock.Anything, mock.AnythingOfType("*model.Table{{.ModuleName}}")).Return(errors.New("database error"))
			},
			expectedErr: errors.New("database error"),
			expectedID:  0,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			tt.setupMock(mockRepo)

			err := mockRepo.Create(ctx, tt.input)

			if tt.expectedErr != nil {
				assert.Equal(t, tt.expectedErr, err, "expected error did not match")
				assert.Zero(t, tt.input.ID, "expected ID to be zero")
			} else {
				require.NoError(t, err, "expected no error")
				require.NotZero(t, tt.input.ID, "expected ID to be set")
				assert.Equal(t, tt.expectedID, tt.input.ID, "expected ID did not match")
			}

			mockRepo.AssertExpectations(t)
		})
	}
}
