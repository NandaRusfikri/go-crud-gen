package impl_test

import (
	"context"
	"errors"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"{{.ModuleNameRoot}}/internal/usecase/{{.ModuleNameLower}}/impl"
	mockrepo "{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
	"{{.ModuleNameRoot}}/internal/usecase/model"
)

func TestUseCase_Create(t *testing.T) {
	testCases := []struct {
		name     string
		setup    func(repo *mockrepo.Mock{{.ModuleName}}Repository)
		request  *model.Create{{.ModuleName}}Request
		expected error
	}{
		{
			name: "Positive case",
			setup: func(repo *mockrepo.Mock{{.ModuleName}}Repository) {
				repo.On("Create", mock.Anything, mock.Anything).Return(nil)
			},
			request: &model.Create{{.ModuleName}}Request{
				// Initialize request fields
			},
			expected: nil,
		},
		{
			name: "Negative case with repository error",
			setup: func(repo *mockrepo.Mock{{.ModuleName}}Repository) {
				repo.On("Create", mock.Anything, mock.Anything).Return(errors.New("repository error"))
			},
			request: &model.Create{{.ModuleName}}Request{
				// Initialize request fields
			},
			expected: errors.New("repository error"),
		},
		// Add more test cases as needed
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			ctx := context.Background()
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			useCase := impl.New(mockRepo)
			tc.setup(mockRepo)

			err := useCase.Create(ctx, tc.request)

			assert.Equal(t, tc.expected, err)
			mockRepo.AssertExpectations(t)
		})
	}
}

