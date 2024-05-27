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
		input       model.TableTask
		setupMock   func(m *mockrepo.MockTaskRepository)
		expected    model.TableTask
		expectedErr error
	}{
		{
			name: "Positive case",
			input: model.TableTask{
				ID:   1,
				Name: "Updated Task",
			},
			setupMock: func(m *mockrepo.MockTaskRepository) {
				m.On("Update", mock.Anything, mock.AnythingOfType("model.TableTask")).Return(model.TableTask{ID: 1, Name: "Updated Task"}, nil)
			},
			expected:    model.TableTask{ID: 1, Name: "Updated Task"},
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			input: model.TableTask{
				ID:   1,
				Name: "Updated Task",
			},
			setupMock: func(m *mockrepo.MockTaskRepository) {
				m.On("Update", mock.Anything, mock.AnythingOfType("model.TableTask")).Return(model.TableTask{}, errors.New("database error"))
			},
			expected:    model.TableTask{},
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.MockTaskRepository)
			tt.setupMock(mockRepo)

			res, err := mockRepo.Update(ctx, tt.input)

			assert.Equal(t, tt.expectedErr, err)
			assert.Equal(t, tt.expected, res)
			mockRepo.AssertExpectations(t)
		})
	}
}