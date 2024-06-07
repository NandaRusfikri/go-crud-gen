package impl_test

import (
"context"
	"errors"
	"testing"
	"context"
	pkgHelper "{{.ModuleNameRoot}}/pkg/helper"

	"github.com/stretchr/testify/assert"
    "github.com/stretchr/testify/mock"
    omodel "{{.ModuleNameRoot}}/internal/outbound/model"
    umodel "{{.ModuleNameRoot}}/internal/usecase/model"
    "{{.ModuleNameRoot}}/internal/usecase/user/impl"
    mockrepo "{{.ModuleNameRoot}}/internal/outbound/db/user"
)

func TestUpdate(t *testing.T) {
	testCases := []struct {
		name          string
		setup         func(repo *mockrepo.MockUserRepository)
		request       *umodel.UpdateUserRequest
		expectedError error
	}{
		{
			name: "Positive case",
			setup: func(repo *mockrepo.MockUserRepository) {
				repo.On("Update", mock.Anything, omodel.TableUser{
					ID:   1,
					Name: "Updated Name",
				}).Return(nil)
			},
			request: &umodel.UpdateUserRequest{
				ID:   1,
				Name: "Updated Name",
			},
			expectedError: nil,
		},
		{
			name: "Negative case with repository error",
			setup: func(repo *mockrepo.MockUserRepository) {
				repo.On("Update", mock.Anything, omodel.TableUser{
					ID:   1,
					Name: "Updated Name",
				}).Return(errors.New("repository error"))
			},
			request: &umodel.UpdateUserRequest{
				ID:   1,
				Name: "Updated Name",
			},
			expectedError: errors.New("repository error"),
		},
		// Add more test cases as needed
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			ctx := context.Background()
			mockRepo := new(mockrepo.MockUserRepository)
			useCase := impl.New(mockRepo)
			tc.setup(mockRepo)

			err := useCase.Update(ctx, tc.request)

			assert.Equal(t, tc.expectedError, err)
			mockRepo.AssertExpectations(t)
		})
	}
}
