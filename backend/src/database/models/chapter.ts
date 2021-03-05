import { DataTypes } from 'sequelize';

/**
 * Chapter database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const chapter = sequelize.define(
    'chapter',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      title: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      chapterDescription: {
        type: DataTypes.TEXT,
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

  chapter.associate = (models) => {
    models.chapter.belongsTo(models.book, {
      as: 'book',
      constraints: false,
    });

    models.chapter.hasMany(models.lesson, {
      as: 'lesson',
      constraints: false,
      foreignKey: 'chapterId',
      
    });
    
    models.chapter.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.chapter.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.chapter.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return chapter;
}
