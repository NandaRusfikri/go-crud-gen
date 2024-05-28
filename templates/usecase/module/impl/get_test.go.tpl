package impl_test

import (
	"context"
	"errors"
	"testing"
    "{{.ModuleNameRoot}}/internal/usecase/{{.ModuleNameLower}}/impl"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	omodel "{{.ModuleNameRoot}}/internal/outbound/model"
	umodel "{{.ModuleNameRoot}}/internal/usecase/model"
	mockrepo "{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
)

func TestGetByID(t *testing.T) {
	testCases := []struct {
		name           string
		setup          func(repo *mockrepo.Mock{{.ModuleName}}Repository)
		id             uint64
		expectedResult umodel.{{.ModuleName}}
		expectedError  error
	}{
		{
			name: "Positive case",
			setup: func(repo *mockrepo.Mock{{.ModuleName}}Repository) {
				repo.On("GetByID", mock.Anything, uint64(1)).Return(omodel.Table{{.ModuleName}}{
					ID:   1,
					Name: "Test {{.ModuleName}}",
					// Add more fields as needed
				}, nil)
			},
			id: 1,
			expectedResult: umodel.{{.ModuleName}}{
				ID:   1,
				Name: "Test {{.ModuleName}}",
				// Add more fields as needed
			},
			expectedError: nil,
		},
		{
			name: "Negative case with repository error",
			setup: func(repo *mockrepo.Mock{{.ModuleName}}Repository) {
				repo.On("GetByID", mock.Anything, uint64(1)).Return(omodel.Table{{.ModuleName}}{}, errors.New("repository error"))
			},
			id:             1,
			expectedResult: umodel.{{.ModuleName}}{},
			expectedError:  errors.New("repository error"),
		},
		// Add more test cases as needed
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			ctx := context.Background()
			mockRepo := new(mockrepo.Mock{{.ModuleName}}Repository)
			useCase := impl.New(mockRepo)
			tc.setup(mockRepo)

			result, err := useCase.GetByID(ctx, tc.id)

			assert.Equal(t, tc.expectedResult, result)
			assert.Equal(t, tc.expectedError, err)
			mockRepo.AssertExpectations(t)
		})
	}
}