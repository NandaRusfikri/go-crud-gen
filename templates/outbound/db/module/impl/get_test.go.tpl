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
		setupMock   func(m *mockrepo.Mock{{.ModuleName}}Repository)
		expected    model.Table{{.ModuleName}}
		expectedErr error
	}{
		{
			name: "Positive case",
			id:   1,
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("GetByID", mock.Anything, uint64(1)).Return(model.Table{{.ModuleName}}{ID: 1, Name: "{{.ModuleName}} 1"}, nil)
			},
			expected:    model.Table{{.ModuleName}}{ID: 1, Name: "{{.ModuleName}} 1"},
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			id:   1,
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("GetByID", mock.Anything, uint64(1)).Return(model.Table{{.ModuleName}}{}, errors.New("database error"))
			},
			expected:    model.Table{{.ModuleName}}{},
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			tt.setupMock(mockRepo)

			res, err := mockRepo.GetByID(ctx, tt.id)

			assert.Equal(t, tt.expectedErr, err)
			assert.Equal(t, tt.expected, res)
			mockRepo.AssertExpectations(t)
		})
	}
}

func TestGetList(t *testing.T) {
	ctx := context.Background()

	tests := []struct {
		name        string
		request     model.GetList{{.ModuleName}}Request
		setupMock   func(m *mockrepo.Mock{{.ModuleName}}Repository)
		expected    []model.Table{{.ModuleName}}
		expectedCnt int64
		expectedErr error
	}{
		{
			name: "Positive case",
			request: model.GetList{{.ModuleName}}Request{
				Search: "{{.ModuleName}}",
				Page:   1,
				Limit:  10,
			},
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("GetList", mock.Anything, mock.AnythingOfType("model.GetList{{.ModuleName}}Request")).Return([]model.Table{{.ModuleName}}{
				    { ID: 1, Name: "{{.ModuleName}} 1"},
				}, int64(1), nil)
			},
			expected:    []model.Table{{.ModuleName}}{
			    {ID: 1, Name: "{{.ModuleName}} 1"},
			},
			expectedCnt: 1,
			expectedErr: nil,
		},
		{
			name: "Negative case with database error",
			request: model.GetList{{.ModuleName}}Request{
				Search: "{{.ModuleName}}",
				Page:   1,
				Limit:  10,
			},
			setupMock: func(m *mockrepo.Mock{{.ModuleName}}Repository) {
				m.On("GetList", mock.Anything, mock.AnythingOfType("model.GetList{{.ModuleName}}Request")).Return([]model.Table{{.ModuleName}}{}, int64(0), errors.New("database error"))
			},
			expected:    []model.Table{{.ModuleName}}{},
			expectedCnt: 0,
			expectedErr: errors.New("database error"),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			tt.setupMock(mockRepo)

			list, count, err := mockRepo.GetList(ctx, tt.request)

			assert.Equal(t, tt.expectedErr, err)
			assert.Equal(t, tt.expected, list)
			assert.Equal(t, tt.expectedCnt, count)
			mockRepo.AssertExpectations(t)
		})
	}
}