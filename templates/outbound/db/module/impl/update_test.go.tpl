package impl

import (
	"context"
	"fmt"
	"testing"
	"github.com/stretchr/testify/assert"
	"github.com/DATA-DOG/go-sqlmock"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
	rmodel "{{.ModuleNameRoot}}/pkg/resource/model"
)

func TestUpdate(t *testing.T) {
	sqlDB, db, mock := {{.ModuleNameLower}}.DbMock(t)
	defer sqlDB.Close()
	implObj := New(rmodel.Database{
		Template: db,
	})
	ctx := context.Background()

	tests := []struct {
		name         string
		input        model.Table{{.ModuleName}}
		mockBehavior func(sqlmock.Sqlmock)
		expected     model.Table{{.ModuleName}}
		expectError  bool
	}{
		{
			name: "Positive case",
			input: model.Table{{.ModuleName}}{
				ID:   1,
				Name: "Updated {{.ModuleName}}",
			},
			mockBehavior: func(mock sqlmock.Sqlmock) {
			    updSQL := "UPDATE \"{{.ModuleNameLower}}\" SET .+"
			    mock.ExpectBegin()
              	mock.ExpectExec(updSQL).WillReturnResult(sqlmock.NewResult(1, 1))
                mock.ExpectCommit()
			},
			expected: model.Table{{.ModuleName}}{
				ID:   1,
				Name: "Updated {{.ModuleName}}",
			},
			expectError: false,
		},
		{
			name: "Negative case with database error",
			input: model.Table{{.ModuleName}}{
				ID:   1,
				Name: "Updated {{.ModuleName}}",
			},
			mockBehavior: func(mock sqlmock.Sqlmock) {
			    updUserSQL := "UPDATE \"{{.ModuleNameLower}}\" SET .+"
                mock.ExpectBegin()
                mock.ExpectExec(updUserSQL).WillReturnError(fmt.Errorf("update failed"))
                mock.ExpectRollback()
			},
			expected:    model.Table{{.ModuleName}}{},
			expectError: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tt.mockBehavior(mock)

			_,err := implObj.Update(ctx, tt.input)

			if tt.expectError {
				assert.Error(t, err)
			} else {
				assert.NoError(t, err)
				assert.Equal(t, tt.expected.ID, tt.input.ID)
				assert.Equal(t, tt.expected.Name, tt.input.Name)
			}

			assert.Nil(t, mock.ExpectationsWereMet())
		})
	}
}
