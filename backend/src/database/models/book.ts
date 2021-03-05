import { DataTypes } from 'sequelize';

/**
 * Book database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const book = sequelize.define(
    'book',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      bookName: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      bookDescription: {
        type: DataTypes.TEXT,
      },
      author: {
        type: DataTypes.TEXT,
      },
      type: {
        type: DataTypes.ENUM,
        values: [
          "FREE",
          "PREMIUM"
        ],
      },
      importHash: {
        type: DataTypes.STRING(255),
        allowNull: true,        
      },
    },
    {
      indexes: [
        {
          unique: true,
          fields: ['importHash', 'tenantId'],
          where: {
            deletedAt: null,
          },
        },

      ],
      timestamps: true,
      paranoid: true,
    },
  );

  book.associate = (models) => {
    models.book.belongsTo(models.level, {
      as: 'level',
      constraints: false,
    });

    models.book.belongsTo(models.classlevel, {
      as: 'classlevel',
      constraints: false,
    });

    models.book.belongsTo(models.subject, {
      as: 'subject',
      constraints: false,
    });

    models.book.hasMany(models.file, {
      as: 'thumbnail',
      foreignKey: 'belongsToId',
      constraints: false,
      scope: {
        belongsTo: models.book.getTableName(),
        belongsToColumn: 'thumbnail',
      },
    });

    models.book.hasMany(models.file, {
      as: 'cover',
      foreignKey: 'belongsToId',
      constraints: false,
      scope: {
        belongsTo: models.book.getTableName(),
        belongsToColumn: 'cover',
      },
    });
    models.book.hasMany(models.chapter, {
      as: 'chapter',
      constraints: false,
      foreignKey: 'bookId',
      
    });
    models.book.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.book.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.book.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return book;
}
