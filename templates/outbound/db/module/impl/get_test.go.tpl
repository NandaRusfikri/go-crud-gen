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



func TestGetByID(t *testing.T) {
	ctx := context.Background()

	tests := []struct {
		name        string
		id          uint64
		setupMock   func(m *mockrepo.MockTaskRepository)
		expected    model.TableTask
		expectedErr error
	}{
		{
			name: "Positive case",
			id:   1,
			setupMock: func(m *mockrepo.MockTaskRepository) {
				m.On("GetByID", mock.Anything, uint64(1)).Return(model.TableTask{ID: 1, Name: "Task 1"}, nil)
			},
			expected:    model.TableTask{ID: 1, Name: "Task 1"},
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			id:   1,
			setupMock: func(m *mockrepo.MockTaskRepository) {
				m.On("GetByID", mock.Anything, uint64(1)).Return(model.TableTask{}, errors.New("database error"))
			},
			expected:    model.TableTask{},
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.MockTaskRepository)
			tt.setupMock(mockRepo)

			res, err := mockRepo.GetByID(ctx, tt.id)

			assert.Equal(t, tt.expectedErr, err)
			assert.Equal(t, tt.expected, res)
			mockRepo.AssertExpectations(t)
		})
	}
}
