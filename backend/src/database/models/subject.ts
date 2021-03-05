import { DataTypes } from 'sequelize';

/**
 * Subject database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const subject = sequelize.define(
    'subject',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      subjectName: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      subjectDescription: {
        type: DataTypes.TEXT,
      },
      active: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
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

  subject.associate = (models) => {
    models.subject.belongsTo(models.level, {
      as: 'level',
      constraints: false,
    });

    models.subject.belongsTo(models.classlevel, {
      as: 'classLevel',
      constraints: false,
    });


    
    models.subject.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.subject.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.subject.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return subject;
}
