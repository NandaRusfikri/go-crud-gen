package impl

import (
	"context"
	"errors"
	"testing"
	"github.com/stretchr/testify/assert"
	"github.com/DATA-DOG/go-sqlmock"
	"{{.ModuleNameRoot}}/internal/outbound/model"
	"{{.ModuleNameRoot}}/internal/outbound/db/{{.ModuleNameLower}}"
	rmodel "{{.ModuleNameRoot}}/pkg/resource/model"
	"time"
)

func TestCreate(t *testing.T) {
	sqlDB, db, mock := {{.ModuleNameLower}}.DbMock(t)
	defer sqlDB.Close()
	implObj := New(rmodel.Database{
		Template: db,
	})
	ctx := context.Background()

	tests := []struct {
		name         string
		input        *model.Table{{.ModuleName}}
		mockBehavior func(sqlmock.Sqlmock)
		expectedErr  error
		expectedID   uint64
	}{
		{
			name: "Positive case",
			input: &model.Table{{.ModuleName}}{
				Name: "Test Name",
			},
			mockBehavior: func(mock sqlmock.Sqlmock) {
				addRow := sqlmock.NewRows([]string{"created_at", "updated_at", "id"}).
                AddRow(time.Now(), time.Now(), 1)
                mock.ExpectBegin()
                mock.ExpectQuery(`INSERT INTO "{{.ModuleNameLower}}" \("name"\) VALUES \(\$1\) RETURNING "created_at","updated_at","id"`).
                    WithArgs("Test Name").
                	WillReturnRows(addRow)
                mock.ExpectCommit()
			},
			expectedErr: nil,
			expectedID:  1,
		},
		{
			name: "Negative case with database error",
			input: &model.Table{{.ModuleName}}{
				Name: "Test Name",
			},
			mockBehavior: func(mock sqlmock.Sqlmock) {
				mock.ExpectBegin()
                mock.ExpectQuery(`INSERT INTO "{{.ModuleNameLower}}" \("name"\) VALUES \(\$1\) RETURNING "created_at","updated_at","id"`).
                    WithArgs("Test Name").
                	WillReturnError(errors.New("database error"))
                mock.ExpectRollback()
			},
			expectedErr: errors.New("database error"),
			expectedID:  0,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tt.mockBehavior(mock)

			err := implObj.Create(ctx, tt.input)

			if tt.expectedErr != nil {
            	assert.Error(t, err)
            } else {
            	assert.NoError(t, err)
            	assert.Equal(t, tt.expectedID, tt.input.ID)
            }

			if err := mock.ExpectationsWereMet(); err != nil {
				t.Errorf("there were unfulfilled expectations: %s", err)
			}
		})
	}
}
